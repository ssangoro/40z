include("0base.jl")
r = Robot("inf_line.sit", animate = true)

function inf_line!(robot)
    side = Ost
    shuttle!(()->!isborder(robot, Nord), robot, side)
end

inf_line!(r)