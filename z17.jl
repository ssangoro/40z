include("0base.jl")
r = Robot("find_mark.sit", animate = true)

function find_mark!(robot)
    spiral!(()->ismarker(robot), robot)
end

find_mark!(r)