include("0base.jl")
r = Robot("empty.sit",animate = true)

function cross!(robot)
    putmarker!(robot)
    side = Ost
    for i in range(1, 4)
        num_mark_along_return!(robot, side)
        side = turn_left(side)
    end
end

function num_mark_along_return!(robot, side)
    num = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        num += 1
    end
    side = inverse(side)
    move!(robot, side, num)
end

cross!(r)