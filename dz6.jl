#подпункт а
function mark_outerwall!(robot)
    step_NordWest = []
    while !isborder(robot,Nord) || !isborder(robot,West)
        push!(step_NordWest, doupora!(robot, Nord))
        push!(step_NordWest, doupora!(robot, West))
    end
    for side in (Ost, Sud, West, Nord)
        mark_line!(robot,side)
    end
    k = 0
    for element in reverse(step_NordWest)
        k % 2 == 0 && move!(robot, Ost, element)
        k % 2 == 1 && move!(robot, Sud, element)
        k += 1
    end
end

function mark_line!(robot,side)
    putmarker!(robot)
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end

function doupora!(robot, side)
    step = 0
    while !isborder(robot,side)
        move!(robot,side)
        step += 1
    end
    return step
end

function HorizonSideRobots.move!(robot,side,num_steps::Integer)
    for _ in 1:num_steps
        move!(robot,side)
    end
end

#подпункт б
function mark_projection!(robot)
    step_Nord = []
    step_West = []
    while !isborder(robot,Nord) || !isborder(robot,West)
        push!(step_Nord, doupora!(robot, Nord))
        push!(step_West, doupora!(robot, West))
    end
    steptoNord = sum(step_Nord)
    move!(robot, Sud, steptoNord)
    putmarker!(robot)
    sizelength = doupora!(robot,Sud)
    sizelength += steptoNord
    move!(robot, Nord, sizelength)
    steptoWest = sum(step_West)
    move!(robot, Ost, steptoWest)
    putmarker!(robot)
    sizewidth = doupora!(robot, Ost)
    sizewidth += steptoWest
    move!(robot, Sud, steptoNord)
    putmarker!(robot)
    doupora!(robot,Sud)
    move!(robot, West, sizewidth - steptoWest)
    putmarker!(robot)
    doupora!(robot, West)
    doupora!(robot, Nord)
    elementNord = 0
    step_Nord = reverse(step_Nord)
    for elementWest in reverse(step_West)
        move!(robot, Ost, elementWest)
        elementNord += 1
        move!(robot, Sud, step_Nord[elementNord])
    end
end







