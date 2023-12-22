include("0base.jl")
r = Robot("empty.sit", animate = true)

function recalon_det!(robot::Robot, side::HorizonSide)
    if !try_move!(robot, side)
        detour!(robot, side)
    end
    recalon_det!(robot, side)
end

function detour!(robot::Robot, side::HorizonSide)
    n = 0
    lside = turn_left(side)
    while !try_move!(robot, side)
        move!(robot, lside)
        n += 1
    end
    move!(robot, inverse(lside), n)
end

