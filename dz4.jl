function krest!(robot)
    putmarker!(robot)
    for side1 in (Nord, Sud)
        for side2 in (Ost, West)
            step_side1 = 0
            step_side2 = 0
            while !isborder(robot,side1) && !isborder(robot,side2)
                move!(robot, side1)
                move!(robot, side2)
                step_side1 += 1
                step_side2 += 1
                putmarker!(robot)
            end
            move!(robot, inverse(side1), step_side1)
            move!(robot, inverse(side2), step_side2)
        end
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end