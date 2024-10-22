function chess!(robot, n::Integer)
    stepsSud = movetoend!(robot, Sud)
    stepsWest = movetoend!(robot, West)
    side = Ost
    flag = true
    mark_line!(robot, side, n, flag)
    count_line = 0
    while !isborder(robot, Nord)
        move!(robot, Nord)
        count_line += 1
        if count_line % n == 0
            flag = !flag
        end
        mark_line!(robot, side, n, flag)
    end
    movetoend!(robot,Sud)
    movetoend!(robot,West)
    move!(robot, Nord, stepsSud)
    move!(robot, Ost, stepsWest)
end

function mark_line!(robot, side, n::Integer, flag::Bool)
    if flag == true
        for _ in 1:n
            isborder(robot,side) == true && break
            putmarker!(robot)
            move!(robot,side)
        end
    end
    if flag == false
        for _ in 1:n
            isborder(robot,side) == true && break
            move!(robot,side)
        end
    end
    while !isborder(robot,side)
        count_steps = 0
        for _ in 1:n
            isborder(robot,side) == true && break
            if flag == false 
                count_steps = n
            end
            flag == false && break 
            move!(robot,side)
            count_steps +=1
        end
        flag = true
        for _ in 1:n
            count_steps !=n && break
            putmarker!(robot)
            isborder(robot,side) == true && break
            move!(robot,side)
        end
    end
    movetoend!(robot, West)
end

function movetoend!(robot, side)
    step = 0
    while !isborder(robot,side)
        move!(robot,side)
        step += 1
    end
    return step
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end
