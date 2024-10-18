function mark_direct!(robot,side)::Int #пропишем, чтобы если функция ничего не вернула, выдалась ошибка, для удобства нахождения
    num_steps::Int = 0 #введём int, чтобы тип не менялся
    while !isborder(robot,side) #или == false
        move!(robot,side)
        putmarker!(robot)
        num_steps += 1
    end
    return num_steps
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end

function cross!(robot)#не задаём тип
    for side in (Nord, Sud, West, Ost) #in <=> знаку принадлежит
        num_steps = mark_direct!(robot,side)
        move!(robot,inverse(side),num_steps)
    end
end
cross!(robot)

