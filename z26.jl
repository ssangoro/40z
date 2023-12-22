include("0base.jl")
r = Robot("mazeana.sit", animate=true)
function maze!(robot::Robot)
    putmarker!(robot)
    side = Ost
    putmarker!(robot)
        if !isborder(robot, turn_right(side))
            fork!(robot, turn_right(side))
        end
        if !isborder(robot, side)
            fork!(robot, side)
        end
        if !isborder(robot, turn_left(side))
            fork!(robot, turn_left(side))
        end
        if !isborder(robot, inverse(side))
            fork!(robot, inverse(side))
        end
end
function fork!(robot::Robot, side::HorizonSide)
    move!(robot, side)
    if !ismarker(robot)
        putmarker!(robot)
        if !isborder(robot, turn_right(side))
            fork!(robot, turn_right(side))
        end
        if !isborder(robot, side)
            fork!(robot, side)
        end
        if !isborder(robot, turn_left(side))
            fork!(robot, turn_left(side))
        end
    end
    move!(robot, inverse(side))
end
maze!(r)