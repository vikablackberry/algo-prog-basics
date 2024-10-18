function outerwall!(robot)
    step_Nord = doupora!(robot, Nord)
    step_West = doupora!(robot,West)
    for side in (Ost, Sud, West, Nord)
        mark_line!(robot,side)
    end
    move!(robot, Sud, step_Nord)
    move!(robot, Ost, step_West)
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

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end