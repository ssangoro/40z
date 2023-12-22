include("0base.jl")
r = Robot("finmark18_2.sit", animate = true)

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

function findetour!(stop_cond::Function, robot::Robot, side::HorizonSide, con::Int, n::Int, ntur::Int)
    lside = turn_left(side)
    nls = 0
    mnls = 0
    if ntur == 0||ntur == 2
        mnls = n
    else
        mnls = n+1
    end
    ncon = n - con
    
    while !try_move!(robot, side)
        move!(robot, lside)
        if stop_cond()
            return true
        end
        nls += 1
        if nls == mnls
            ntur += 1
            if ntur == 2
                n += 1
            elseif ntur == 4
                n += 1
                ntur = 0
            end
            side = turn_left(side)
            ntur += 1
            if ntur == 2
                n += 1
            elseif ntur == 4
                n += 1
                ntur = 0
            end
            side = turn_left(side)
            return finline_det_cut!(()->stop_cond(), robot, side, n, ncon, ntur)
        end
    end

    con += 1

    while isborder(robot, inverse(lside))
        if con == n
            ntur += 1
            if ntur == 2
                n += 1
            elseif ntur == 4
                n += 1
                ntur = 0
            end
            side = turn_left(side)
            return finline_det_cut!(()->stop_cond(), robot, side, n, nls, ntur)
        end
        move!(robot, side)
        if stop_cond()
            return true
        end
        con += 1
    end

    for i in range(1, nls)
        move!(robot, inverse(lside))
        if stop_cond()
            return true
        end
    end
    return finline_det_cut!(()->stop_cond(), robot, side, n, con, ntur)
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

spiral_det!(()->ismarker(r), r)





