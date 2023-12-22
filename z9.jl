include("0base.jl")
r = Robot("empty2.sit", animate = true)

function chessb!(robot)
    num_nord = numsteps_along!(robot, Sud)
    num_ost = numsteps_along!(robot, West)
    side = Ost
    if num_nord%2 == num_ost%2
        rb = 1
        putmarker!(robot)
    else
        rb = 2
    end
    chess_row!(robot, side, rb)
    side = inverse(side)

    while !isborder(robot, Nord)
        move!(robot, Nord)
        rb = chess_row!(robot, side, rb)
        side = inverse(side)
    end
    along!(robot, Sud)
    along!(robot, West)
    move!(robot, Nord, num_nord)
    move!(robot, Ost, num_ost)
end

function chess_row!(robot, side, rb)
    if rb == 1
        putmarker!(robot)
    end

    while !isborder(robot, side)
        move!(robot, side)
        rb +=1
        if rb%2 == 1
            putmarker!(robot)
        end
    end
    if ismarker(robot)
        return 2
    else
        return 1
    end
end
        
chessb!(r)


