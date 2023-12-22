include("0base.jl")
r = Robot("empty2.sit", animate = true)

function chessb!(robot)
    num_nord = numsteps_along!(robot, Sud)
    num_ost = numsteps_along!(robot, West)
    side = Ost
    if num_nord%2 != num_ost%2
        move!(robot, side)
    end

    snake_chess!(robot, side, Nord)
    
    along!(robot, Sud)
    along!(robot, West)
    move!(robot, Nord, num_nord)
    move!(robot, Ost, num_ost)
end

function snake_chess!(robot::Robot, side::HorizonSide, t_side::HorizonSide)
    tik = along_chess!(robot, side, 0)
    side = inverse(side)
    while try_move!(robot, t_side)
        tik = along_chess!(robot, side, tik+1)
        side = inverse(side)
    end
end

function along_chess!(robot::Robot, side::HorizonSide, num::Int)
    if num%2 == 0
        putmarker!(robot)
    end
    while !isborder(robot, side)
        move!(robot, side)
        num += 1
        if num%2 == 0
            putmarker!(robot)
        end
    end
    return num
end

chessb!(r)