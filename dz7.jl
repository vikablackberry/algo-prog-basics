using HorizonSideRobots
robot = Robot(animate = true)
function findpassage!(robot)
    step = 1
    side = Ost
    while isborder(robot, Nord)
        move!(robot, side, step)
        side = inverse(side)
        step += 1
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end