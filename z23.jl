include("0base.jl")
r = Robot("empty.sit", animate = true)

function doublebord!(robot::Robot, side::HorizonSide, find::Bool, ret::Bool, n::Int)
    if find
        if try_move!(robot, side)
            doublebord!(robot, side, true, false, n+1)
        else
            doublebord!(robot, side, false, false, n)
        end
    else
        if !ret
            if try_move!(robot, inverse(side))
                doublebord!(robot, side, false, false, n)
            else
                doublebord!(robot, side, false, true, n)
            end
        else
            if n > 0
                move!(robot, side)
                doublebord!(robot, side, false, true, n-1)
            end
        end
    end  
end

doublebord!(r, Ost, true, false, 0)