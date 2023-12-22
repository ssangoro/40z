using HorizonSideRobots
HSR = HorizonSideRobots

mutable struct Coordinates 
    x::Int
    y::Int
end

mutable struct ChessRobot
    robot::Robot
    coords::Coordinates
    n::Integer
end

function ifmarker(cr::ChessRobot)
    return (mod(get_x(cr), cr.n*2) < cr.n &&
    mod(get_y(cr), cr.n*2) < cr.n ) ||
    !(mod(get_x(cr), cr.n*2) < cr.n  ||
    mod(get_y(cr), cr.n*2) < cr.n )  
end


function HSR.move!(cr::ChessRobot, side::HorizonSide)
    if ifmarker(cr)
        putmarker!(get_base_robot(cr))
    end
    if side == Nord
        move!(cr.robot, Nord)
        cr.coords.y += 1
    elseif side == Ost
        move!(cr.robot, Nord)
        cr.coords.x += 1
    elseif side == Sud
        move!(cr.robot, Nord)
        cr.coords.y -= 1
    else #side == West
        move!(cr.robot, Nord)
        cr.coords.x -= 1
    end
    if ifmarker(cr)
        putmarker!(get_base_robot(cr))
    end
end

function ChessRobot(num_rows::Integer=10, num_colons::Integer=10; animate=true, sit=nothing, n=1)
    if isnothing(sit)
        robot = Robot(num_rows, num_colons, animate=animate)
    else
        robot = Robot(sit, animate=animate)
    end
    return ChessRobot(robot, Coordinates(0, 0), n)
end

function get_base_robot(cr::ChessRobot)
    return cr.robot
end

function get_x(cr::ChessRobot)
    return cr.coords.x
end

function get_y(cr::ChessRobot)
    return cr.coords.y
end







