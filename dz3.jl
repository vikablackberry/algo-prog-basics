function pole!(robot)
    stepsSud = doupora!(robot, Sud)
    stepsWest = doupora!(robot, West)
    side = Ost
    mark_line!(robot, side)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        mark_line!(robot, inverse(side))
        side = inverse(side)
    end
    doupora!(robot,Sud)
    doupora!(robot,West)
    move!(robot, Nord, stepsSud)
    move!(robot, Ost, stepsWest)
end

function doupora!(robot, side)::Int
    step = 0
    while !isborder(robot,side)
        move!(robot,side)
        step += 1
    end
    return step
end

function mark_line!(robot,side)
    putmarker!(robot)
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end