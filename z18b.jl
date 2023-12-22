include("0base.jl")
r = Robot("z18b1.sit", animate = true)

function spiral_det!(stop_cond::Function, robot::Robot)
    n = 1
    con = 0
    ntur = 0
    side = Ost
    n = !finline_det!(()->stop_cond(), robot, side, n , ntur)
    while n
        n = !finline_det!(()->stop_cond(), robot, side, n , ntur)
    end
end

function finline_det!(stop_cond::Function, robot::Robot, side::HorizonSide, n::Int, ntur::Int)
    con = 0
    for i in range(1, n)
        if try_move!(robot, side)
            con += 1
            if stop_cond()
                return true
            end
        else
            return findetour!(()->stop_cond(), robot, side, con, n, ntur)
        end
    end
    ntur += 1
    if ntur == 2
        n += 1
    elseif ntur == 4
        n += 1
        ntur = 0
    end
    side = turn_left(side)
    return finline_det!(()->stop_cond(), robot, side, n, ntur)
end

function finline_det_cut!(stop_cond::Function, robot::Robot, side::HorizonSide, n::Int, ncon::Int, ntur::Int)
    con = ncon
    while con < n
        if try_move!(robot, side)
            con += 1
            if stop_cond()
                return true
            end
        else
            return findetour!(()->stop_cond(), robot, side, con, n, ntur)
        end
    end
    ntur += 1
    if ntur == 2
        n += 1
    elseif ntur == 4
        n += 1
        ntur = 0
    end
    side = turn_left(side)
    return finline_det!(()->stop_cond(), robot, side, n, ntur)
end

function shuttle_cons!(stop_cond::Function, stop2_cond::Function, robot::Robot, side::HorizonSide)
    n = 1
    while !stop_cond()
        move!(robot, side, n)
        side = inverse(side)
        if stop2_cond()
            return 0, side
        end
        n += 1
    end
    if n % 2 == 0
        return n, side
    else 
        return n//2 + 1, side
    end
end

function findetour!(stop_cond::Function, robot::Robot, side::HorizonSide, con::Int, n::Int, ntur::Int)
    lside = turn_left(side)
    steps, opside = shuttle_cons!(()->!isborder(robot, side), ()->stop_cond(), robot, lside)
    if steps == 0
        return true
    end
    move!(robot, side)
    con += 1
    for i in range(1, steps)
        move!(robot, opside)
        if stop_cond()
            return true
        end
    end
    return finline_det_cut!(()->stop_cond(), robot, side, n, con, ntur)
end


spiral_det!(()->ismarker(r), r)





