include("0base.jl")
r = Robot("find_mark.sit", animate = true)

function find_mark!(robot)
    num = 1
    n_tur = 0
    side = Ost
    if_fin_mark = 0
    while if_fin_mark == 0
        for i in range(1, num)
            move!(robot, side)
            if ismarker(robot)
                if_fin_mark = 1
                break
            end
        end
        n_tur += 1
        side = turn_left(side)
        if n_tur%2 == 0
            num+=1
        end
    end
end

find_mark!(r)