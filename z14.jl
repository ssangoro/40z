include("0base.jl")
r = Robot("csp.sit", animate = true)

function chessb!(robot)
    numsnord = []
    numsost = []
    while any([!isborder(robot, Sud), !isborder(robot, West)])
        push!(numsnord, numsteps_along!(robot, Sud))
        push!(numsost, numsteps_along!(robot, West))
    end

    side = Ost
    if sum(numsnord)%2 != sum(numsost)%2
        move!(robot, side)
    end

    snake_chess_pd!(robot, side, Nord)
    
    along!(robot, Sud)
    along!(robot, West)
    for i in range(start = length(numsnord), stop = 1, step = -1)
        move!(robot, Ost, numsost[i])
        move!(robot, Nord, numsnord[i])
    end
end

function snake_chess_pd!(robot::Robot, side::HorizonSide, t_side::HorizonSide)
    tik = along_chess_pd!(robot, side, 0)
    side = inverse(side)
    while try_move!(robot, t_side)
        tik = along_chess_pd!(robot, side, tik+1)
        side = inverse(side)
    end
end

function along_chess_pd!(robot::Robot, side::HorizonSide, num::Int)
    if num%2 == 0
        putmarker!(robot)
    end
    td = true
    while td
        if try_move!(robot, side)
            num += 1
            if num%2 == 0
                putmarker!(robot)
            end
        else
            td, num = try_detour!(robot, side, num)
            if num%2 == 0
                putmarker!(robot)
            end
        end
    end
    return num
end

function try_detour!(robot::Robot, side::HorizonSide, num::Int)
    noret = true
    vcon = 0
    while !try_move!(robot, side)
        if !try_move!(robot, Nord)
            noret = false
            break
        else
            vcon += 1
        end
    end
    
    if noret
        gcon = 1
        while isborder(robot, Sud)
            move!(robot, side)
            gcon += 1
        end
        move!(robot, Sud, vcon)
        return true, (num+gcon)
    else
        move!(robot, Sud, vcon)
        return false, num
    end
end


chessb!(r)