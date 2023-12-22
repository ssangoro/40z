include("0base.jl")
r = Robot("per_pro.sit", animate = true)

function mark_perimter!(robot)
    numsnord = []
    numsost = []
    
    while any([!isborder(robot, Sud), !isborder(robot, West)])
        push!(numsnord, numsteps_along!(robot, Sud))

        push!(numsost, numsteps_along!(robot, West))
    end
    num_nord = 0
    num_ost = 0
    for i in numsnord
        num_nord += i
    end
    for i in numsost
        num_ost+= i
    end

    move!(robot, Ost, num_ost)
    putmarker!(robot)
    along!(robot, Ost)
    move!(robot, Nord, num_nord)
    putmarker!(robot)
    along!(robot, Sud)
    along!(robot, West)
    move!(robot, Nord, num_nord)
    putmarker!(robot)
    along!(robot, Nord)
    move!(robot, Ost, num_ost)
    putmarker!(robot)
    along!(robot, West)
    along!(robot, Sud)


    for i in range(start = length(numsnord), stop = 1, step = -1)
        move!(robot, Ost, numsost[i])
        move!(robot, Nord, numsnord[i])
    end
end

mark_perimter!(r)