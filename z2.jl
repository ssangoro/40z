include("0base.jl")
r = Robot("empty.sit", animate = true)

function mark_perimter!(robot)
    num_nord = numsteps_along!(robot, Sud)
    num_ost = numsteps_along!(robot, West)
    side = Ost
    for i in range(1, 4)
        mark_along!(robot, side)
        side = turn_left(side)
    end
    move!(robot, Ost, num_ost)
    move!(robot, Nord, num_nord)
end

mark_perimter!(r)