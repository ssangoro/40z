include("0base.jl")
r = Robot("field.sit", animate = true)

function mark_2_perimter!(robot)
    num_nord_2 = numsteps_along!(robot, Sud)
    num_ost = numsteps_along!(robot, West)
    num_nord_1 = numsteps_along!(robot, Sud)
    side = Ost
    for i in range(1, 4)
        mark_along!(robot, side)
        side = turn_left(side)
    end

    find_border!(robot)
    per_in!(robot)

    along!(robot, Sud)
    along!(robot, West)

    move!(robot, Nord, num_nord_1)

    move!(robot, Ost, num_ost)
    
    move!(robot, Nord, num_nord_2)
end


function per_in!(robot)
    side = Ost
    bside = Nord
    for i in range(1, 4)
        move!(robot, side)
        putmarker!(robot)
        while isborder(robot, bside)
            move!(robot, side)
            putmarker!(robot)
        end
        side = turn_left(side)
        bside = turn_left(bside)
    end
end

function find_border!(robot)
    side = Ost
    fin_2b = false

    while !isborder(robot, Nord)
        fin_2b = move_check!(robot, side)
        if !fin_2b
            move!(robot, Nord)
            side = inverse(side)
        end
    end

    while isborder(robot, Nord)
        move!(robot, West)
    end

end

function move_check!(robot, side)
    check = 0
    while all([!isborder(robot, side), check == 0])
        move!(robot, side)
        if isborder(robot, Nord)
            check = 1
        end
    end
    return isborder(robot, Nord)
end


mark_2_perimter!(r)