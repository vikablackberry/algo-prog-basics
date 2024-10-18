function pole!(robot, flag::Bool)
    for sides in ((Nord,West), (Sud, Ost))
        side2 = sides[2]
        stepsside2 = markline_beginr!(robot, sides[2], flag)
        stepsside1 = 0
        while !isborder(robot, sides[1])
            flag = !(ismarker(robot))
            stepsside1 += 1
            move!(robot, sides[1])
            markline_beginr!(robot, inverse(side2), flag)
            side2 = inverse(side2)
        end
        doupora!(robot, sides[1])
        doupora!(robot,sides[2])
        move!(robot, inverse(sides[1]), stepsside1)
        move!(robot, inverse(sides[2]), stepsside2)
    end
end
function markline_beginr!(robot, side, flag::Bool)
    stepWest = 0
    flag == 1 && putmarker!(robot)
    flag = !flag
    while !isborder(robot,side)
        move!(robot,side)
        stepWest += 1
        flag == 1 && putmarker!(robot)
        flag = !(flag)#(flag + 1)%2
    end
    return stepWest
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
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