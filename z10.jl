include("0base.jl")
r = Robot("empty.sit", animate = true)

function chessbn!(robot, n::Int)
    num_ost = numsteps_along!(robot, West)
    num_nord = numsteps_along!(robot, Sud)

    st = 1
    side = Ost
    h = 0


    st = row_n_chess!(robot, side, st, h, n)
    hest = 1
    side = inverse(side)
    if hest == n
        h+=1
        hest = 0
    end

    while !isborder(robot, Nord)
        move!(robot, Nord)
        st = row_n_chess!(robot, side, st, h, n)
        hest += 1
        side = inverse(side)
        if hest == n
            h += 1
            hest = 0
        end
    end

    along!(robot, Sud)
    along!(robot, West)
    move!(robot, Nord, num_nord)
    move!(robot, Ost, num_ost)
end

function row_n_chess!(robot, side, st, h, n)
    if h%2 == 0
        if side == Ost
            while !isborder(robot, side)
                if 1 <= st <= n
                    putmarker!(robot)
                end
                if st == 2*n
                    st = 0
                end
                while all([st < n, !isborder(robot, side)])
                    if try_move_mark!(robot, side)
                        st += 1
                    end
                end
                while all([st < 2*n, !isborder(robot, side)])
                    if try_move!(robot, side)
                        st += 1
                    end
                end
            end
        else
            while !isborder(robot, side)
                if 1 <= st <= n
                    putmarker!(robot)
                end
                if st == 1
                    st = 2*n+1
                end
                while all([st > n+1, !isborder(robot, side)])
                    if try_move!(robot, side)
                        st -= 1
                    end
                end
                while all([st > 1, !isborder(robot, side)])
                    if try_move_mark!(robot, side)
                        st -= 1
                    end
                end
            end
        end
    else
        if side == Ost
            while !isborder(robot, side)
                if st > n
                    putmarker!(robot)
                end
                if st == 2*n
                    st = 0
                end
                while all([st < n, !isborder(robot, side)])
                    if try_move!(robot, side)
                        st += 1
                    end
                end
                while all([st < 2*n, !isborder(robot, side)])
                    if try_move_mark!(robot, side)
                        st += 1
                    end
                end
            end
        else
            while !isborder(robot, side)
                if st > n
                    putmarker!(robot)
                end
                if st == 1
                    st = 2*n + 1
                end
                while all([st > n+1, !isborder(robot, side)])
                    if try_move_mark!(robot, side)
                        st -= 1
                    end
                end
                while all([st > 1, !isborder(robot, side)])
                    if try_move!(robot, side)
                        st -= 1
                    end
                end
            end
        end
    end
    return st
end

chessbn!(r, 4)

