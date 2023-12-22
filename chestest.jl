include("chessr.jl")
include("0base.jl")

cr = ChessRobot()

function try_move!(robot::ChessRobot, side::HorizonSide)
    if !isborder(get_base_robot(robot), side)
        move!(robot, side)
        return true
    else
        return false
    end
end

function snake!(robot::ChessRobot, side::HorizonSide, t_side::HorizonSide)
    along!(robot, side)
    side = inverse(side)
    while try_move!(robot, t_side)
        along!(robot, side)
        side = inverse(side)
    end
end


function along!(robot::ChessRobot, side::HorizonSide)
    while !isborder(get_base_robot(robot), side)
        move!(robot, side)
    end
end


function nches(cr::ChessRobot, n::Int)
    cr.n = n
    snake!(cr, Ost, Nord)
end

nches(cr, 2)