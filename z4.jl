include("0base.jl")
r = Robot("empty.sit", animate = true)

function curve_cross!(robot)
    putmarker!(robot)
    side = Ost
    for i in range(1, 4)
        curve_num_mark_along_return!(robot, side)
        side = turn_left(side)
    end
end

function curve_num_mark_along_return!(robot, side)
    num = 0
    lside = turn_left(side)
    while !isborder(robot, side) == !isborder(robot, lside) == 1
        move!(robot, side)
        move!(robot, lside)
        putmarker!(robot)
        num += 1
    end
    side = inverse(side)
    lside = inverse(lside)
    for i in range(1, num)
        move!(robot, lside)
        move!(robot, side)
    end
end


curve_cross!(r)