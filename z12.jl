include("0base.jl")
r = Robot("count_g_br25.sit",animate = true)

function gbrs_count_holes!(robot)
    n_ost = numsteps_along!(robot, West)
    n_nord = numsteps_along!(robot, Sud)
    side = Ost
    countf = count_borders_holes!(robot, side)
    side = inverse(side)

    while !isborder(robot, Nord)
        move!(robot, Nord)
        countf += count_borders_holes!(robot, side)
        side = inverse(side)
    end
    
    along!(robot, West)
    along!(robot, Sud)

    move!(robot, Nord, n_nord)
    move!(robot, Ost, n_ost)

    return countf
end

function count_borders_holes!(robot, side)
    count = 0
    if isborder(robot, Nord)
        st = 1
    else
        st = 0
    end

    while !isborder(robot, side)
        move!(robot, side)
        if st == 0
            if isborder(robot, Nord) 
                st = 1
            end
        elseif st == 1
            if !isborder(robot, Nord)
                st = 2
            end
        else
            if !isborder(robot, Nord)
                st = 0
                count+=1
            else
                st = 1
            end
        end
    end

    if st == 2
        count+=1
    end

    return count
end

print(gbrs_count_holes!(r))

