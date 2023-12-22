include("0base.jl")
r = Robot("csp.sit", animate = true)

function curve_cross_pd!(robot)
    putmarker!(robot)
    side = Ost
    for i in range(1, 4)
        curve_num_mark_along_return_pd!(robot, side)
        side = turn_left(side)
    end
end

function curve_num_mark_along_return_pd!(robot::Robot, side::HorizonSide)
    num_side = 0
    num_lside = 0
    iscor = false
    lside = turn_left(side)
    while !iscor
        if try_move!(robot, lside)
            num_lside += 1
            if try_move!(robot, side)
                num_side += 1                
                putmarker!(robot)
            else
                iscor, num_side, num_lside = try_detour_sc!(robot, side, num_side, num_lside)
            end
        else
            iscor, num_side, num_lside = try_detour_lc!(robot, lside, num_side, num_lside)
        end
    end
    curve_return_pd!(robot, side, num_side, num_lside)
end

function try_detour_sc!(robot::Robot, side::HorizonSide, num_side::Int, num_lside::Int)
    lside = turn_left(side)
    nl = 0
    ns = 0
    lc = 0
    con = 0
    while !try_move!(robot, side)
        if try_move!(robot, lside)
            lc += 1
        else
            move!(robot, inverse(lside), lc)
            return true, num_side, num_lside
        end
    end
    ns += 1
    
    while isborder(robot, inverse(lside)) && (lc != con)
        move!(robot, side)
        con += 1
    end

    if lc == con
        putmarker!(robot)
        nl += lc
        ns += con
    else
        move!(robot, inverse(lside), (lc - con))
        nl += con
        ns += con
        putmarker!(robot)
    end

    return false, num_side + ns, num_lside+nl
end

function try_detour_lc!(robot::Robot, lside::HorizonSide, num_side::Int, num_lside::Int)
    side = turn_right(lside)
    nl = 0
    ns = 0
    lc = 0
    con = 0
    while !try_move!(robot, lside)
        if try_move!(robot, side)
            con += 1
        else
            move!(robot, inverse(side), con)
            return true, num_side, num_lside
        end
    end
    lc += 1
    
    while isborder(robot, inverse(side)) && (lc != con)
        move!(robot, lside)
        lc += 1
    end

    if lc == con
        putmarker!(robot)
        nl += lc
        ns += lc
    else
        move!(robot, inverse(side), (con - lc))
        nl += lc
        ns += lc
        putmarker!(robot)
    end

    return false, num_side + ns, num_lside+nl
end

function curve_return_pd!(robot::Robot, side::HorizonSide, num_side::Int, num_lside::Int)
    lside = turn_left(side)
    opside = inverse(side)
    oplside = inverse(lside)
    move!(robot, opside, num_side)
    while num_lside != 0
        if try_move!(robot, oplside)
            num_lside -= 1
        else
            num_lside = detour_c!(robot, oplside, num_lside)
        end
    end
end

function detour_c!(robot::Robot, side::HorizonSide, num::Int)
    lside = turn_left(side)
    con = 0
    while !try_move!(robot, side)
        move!(robot, lside)
        con += 1
    end
    num -= 1
    while isborder(robot, inverse(lside))
        move!(robot, side)
        num -= 1
    end
    move!(robot, inverse(lside), con)
    return num
end

curve_cross_pd!(r)