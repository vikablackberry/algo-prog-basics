#маркеры вдоль всех стенок/перегородок, есть внутрення и внешняя рамка
function wall!(robot)
    step_Nord = []#doupora вниз, вправо и т.д, пока не  окажемся в углу
    step_West = []
    push!(step_Nord, doupora!(robot, Nord))
    push!(step_West, doupora!(robot, West))
    push!(step_Nord, doupora!(robot, Nord))
    for side in (Ost, Sud, West, Nord)
        mark_line!(robot,side)
    end
    side = do_innerwall!(robot)
    mark_innerwall!(robot, side)
    doupora!(robot, Nord)
    doupora!(robot, West)
    move!(robot, Sud, step_Nord[2])
    move!(robot, Ost, step_West[1])
    move!(robot, Sud, step_Nord[1])
end

#найти внутренню рамку
function do_innerwall!(robot)
    side = Ost
    strochka = doupora!(robot, side)
    while !isborder(robot,Sud)
        move!(robot,Sud)
        side = inverse(side)
        numsteps = doupora!(robot, side)
        if strochka != numsteps
            return side 
        end
    end
end
#отметить внутреннюю рамку
function mark_innerwall!(robot, side)
    kolcycl = 0
    for napr in (side, Nord, inverse(side), Sud)
        kolcycl += 1
        hod = [Sud, side, Nord, inverse(side)]
        while isborder(robot, napr)
            putmarker!(robot)
            move!(robot, hod[kolcycl])            
        end
        putmarker!(robot)
        move!(robot, napr)
        putmarker!(robot)
        
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)       

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

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end