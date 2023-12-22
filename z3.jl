include("0base.jl")
r = Robot("empty.sit",animate = true)

function fill_mark!(robot)
    num_nord = numsteps_along!(robot, Sud)
    num_ost = numsteps_along!(robot, West)
    side = Ost
    putmarker!(robot)
    mark_along!(robot, side)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        putmarker!(robot)
        side = inverse(side)
        mark_along!(robot, side)
    end
    along!(robot, West)
    along!(robot, Sud)
    move!(robot, Ost, num_ost)
    move!(robot, Nord, num_nord)
end


fill_mark!(r)