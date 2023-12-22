include("0base.jl")
r = Robot("per_pro.sit", animate = true)

function mark_perimter!(robot)
    numsnord = []
    numsost = []
    while any([!isborder(robot, Sud), !isborder(robot, West)])
        push!(numsnord, numsteps_along!(robot, Sud))
        push!(numsost, numsteps_along!(robot, West))
    end
    side = Ost
    for i in range(1, 4)
        mark_along!(robot, side)
        side = turn_left(side)
    end

    for i in range(start = length(numsnord), stop = 1, step = -1)
        move!(robot, Ost, numsost[i])
        move!(robot, Nord, numsnord[i])
    end
end

mark_perimter!(r)