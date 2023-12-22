include("0base.jl")
r = Robot("empty.sit", animate = true)

function recalon!(robot::Robot, side::HorizonSide)
    if try_move!(robot, side)
        recalon!(robot, side)
    end
end

recalon!(r, West)