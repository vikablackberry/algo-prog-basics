function count_partitions!(robot)
    res = 0
    steps = findcorner!(robot, Sud, West)
    side = Ost
    res += count_partitionsline!(robot, side, Nord)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        if !isborder(robot, Nord)
            res += count_partitionsline!(robot, inverse(side), Nord)
        end
        side = inverse(side)
    end
    findcorner!(robot, Sud, West)
    backfromcorner!(robot, Sud, West, steps)
    return res
end

function findcorner!(robot, side1::HorizonSide, side2::HorizonSide) #side1 in (Nord, Sud), side2 in (West, Ost)
    steps = []
    while !isborder(robot, side1) || !isborder(robot,side2)
        push!(steps, movetoend!(robot, side1))
        push!(steps, movetoend!(robot, side2))
    end
    return steps
end

function backfromcorner!(robot, side1::HorizonSide, side2::HorizonSide, steps::Vector)
    k = 0
    for element in reverse(steps)
        k % 2 == 0 && move!(robot, inverse(side2), element)
        k % 2 == 1 && move!(robot, inverse(side1), element)
        k += 1
    end
end

function count_partitionsline!(robot, side, sidepartitions)::Integer
    count = 0
    while !isborder(robot,side)
        if isborder(robot, sidepartitions)
            while isborder(robot, sidepartitions)
                move!(robot,side)
            end
            count += 1
        end
        !isborder(robot,side) && move!(robot,side)
    end
    return count
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function movetoend!(robot, side)
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