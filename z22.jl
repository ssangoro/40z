include("0base.jl")
r = Robot("empty.sit", animate = true)

function doublebord!(robot::Robot, side::HorizonSide, find::Bool, ret::Bool, n::Int, k::Int)
    if find
        if try_move!(robot, side)
            doublebord!(robot, side, true, false, n+1, k+2)
        else
            doublebord!(robot, side, false, false, n, k)
        end
    else
        if !ret
            if k > 0
                if try_move!(robot, inverse(side))
                    doublebord!(robot, side, false, false, n, k-1)
                else
                    doublebord!(robot, side, false, true, n, k)
                end
            else
                return true
            end
        else
            if k < n
                move!(robot, side)
                doublebord!(robot, side, false, true, n, k+1)
            else
                return false
            end
        end
    end  
end

doublebord!(r, Ost, true, false, 0, 0)