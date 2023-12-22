include("0base.jl")
r = Robot("empty.sit", animate = true)

function rechesalon!(robot::Robot, side::HorizonSide)
    if try_move!(robot, side)
        putmarker!(robot)
        rempalon!(robot, side)
    end
end

function rempalon!(robot::Robot, side::HorizonSide)
    try_move!(robot, side)
    rechesalon!(robot, side)
end

rechesalon!(r, West)