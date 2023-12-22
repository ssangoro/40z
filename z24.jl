include("0base.jl")
r = Robot("empty.sit", animate = true)

function doublebord!(robot::Robot, side::HorizonSide)
    if try_move!(robot, side)
        dubbord!(robot, side)
        move!(robot, inverse(side))
    end
end
function dubbord!(robot::Robot, side::HorizonSide)
    try_move!(robot, side)
    doublebord!(robot, side)
end
doublebord!(r, West)