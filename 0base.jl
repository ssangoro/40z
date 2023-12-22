using HorizonSideRobots
HSR = HorizonSideRobots
function HSR.move!(robot::Robot, side::HorizonSide, num::Int)
    for i in range(1, num)
        move!(robot, side)
    end
end

function along!(robot::Robot, side::HorizonSide)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

function numsteps_along!(robot::Robot, side::HorizonSide)
    num = 0
    while !isborder(robot, side)
        move!(robot, side)
        num += 1
    end
    return num
end

function mark_along!(robot::Robot, side::HorizonSide)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
end

function inverse(side::HorizonSide)
    if side == Ost
        side = West
    elseif side == West
        side = Ost
    elseif side == Sud
        side = Nord
    else
        side = Sud
    end
    return side
end

function turn_left(side::HorizonSide)
    if side == Ost
        side = Nord
    elseif side == West
        side = Sud
    elseif side == Sud
        side = Ost
    else
        side = West
    end
    return side
end

function turn_right(side::HorizonSide)
    if side == Ost
        side = Sud
    elseif side == West
        side = Nord
    elseif side == Sud
        side = West
    else
        side = Ost
    end
    return side
end

function try_move!(robot::Robot, side::HorizonSide)
    if !isborder(robot, side)
        move!(robot, side)
        return true
    else
        return false
    end
end

function try_move_mark!(robot::Robot, side::HorizonSide)
    if !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        return true
    else
        return false
    end
end

function try_move!(robot::Robot, side::HorizonSide, num::Int)
    for i in range(1, num)
        if !isborder(robot, side)
            move!(robot, side)
        else 
            return i - 1
        end
    end
    return num
end

function try_move_mark!(robot::Robot, side::HorizonSide, num::Int)
    for i in range(1, num)
        if !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        else 
            return i - 1
        end
    end
    return num
end

function along!(robot::Robot, side::HorizonSide, stop_cond::Function)
    while !stop_cond && !isborder(robot, side)
        move!(robot, side)
    end
end

function snake!(robot::Robot, side::HorizonSide, t_side::HorizonSide)
    along!(robot, side)
    side = inverse(side)
    while try_move!(robot, t_side)
        along!(robot, side)
        side = inverse(side)
    end
end

function snake!(robot::Robot, side::HorizonSide, t_side::HorizonSide, stop_cond::Function)
    along!(robot, side, stop_cond)
    side = inverse(side)
    while !stop_cond && try_move!(robot, t_side)
        along!(robot, side, stop_cond)
        side = inverse(side)
    end
end

function shuttle!(stop_cond::Function, robot::Robot, side::HorizonSide)
    n = 1
    while !stop_cond()
        move!(robot, side, n)
        side = inverse(side)
        n += 1
    end
end

function spiral!(stop_cond::Function, robot::Robot)
    n = 1
    n_tur = 0
    side = Ost
    while !stop_cond()
        for i in range(1, n)
            move!(robot, side)
            if stop_cond()
                break
            end
        end
        n_tur += 1
        side = turn_left(side)
        if n_tur%2 == 0
            n += 1
        end
    end
end

function right(robot, side)
    move!(robot, turn_right(side))
end

function left(robot, side)
    move!(robot, turn_left(side))
end

function back(robot, side)
    move!(robot, inverse(side))
end


