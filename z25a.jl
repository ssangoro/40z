include("0base.jl")
r = Robot("empty.sit", animate = true)

function rechesalon!(robot::Robot, side::HorizonSide)
    putmarker!(robot)
    if try_move!(robot, side)
        rempalon!(robot, side)
    end
end

function rempalon!(robot::Robot, side::HorizonSide)
    try_move!(robot, side)
    rechesalon!(robot, side)
end

rechesalon!(r, West)