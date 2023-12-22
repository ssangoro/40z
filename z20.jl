include("0base.jl")
r = Robot("empty.sit", animate = true)

function recalon_mark_return!(robot::Robot, side::HorizonSide, n::Int)
    if try_move!(robot, side)
        n += 1
        recalon_mark_return!(robot, side, n)
    else
        putmarker!(robot)
        move!(robot, inverse(side), n)
    end
end

recalon_mark_return!(r, West, 0)
