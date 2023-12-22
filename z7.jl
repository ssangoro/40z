include("0base.jl")
r = Robot("inf_line.sit",animate = true)

function inf_line_op!(robot)
    n = 0
    side = Ost
    while isborder(robot, Nord)
        n+=1
        move!(robot, side, n)
        side = inverse(side)
    end
end

inf_line_op!(r)