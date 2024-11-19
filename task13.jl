using HorizonSideRobots

mutable struct ChessMarkRobot
    robot::Robot
    flag::Bool
end

getbaserobot(robot::ChessMarkRobot) = robot.robot

function HorizonSideRobots.isborder(robot::ChessMarkRobot, side)
    isborder(getbaserobot(robot), side)
end
function HorizonSideRobots.putmarker!(robot::ChessMarkRobot)
    putmarker!(getbaserobot(robot))
end

function HorizonSideRobots.move!(robot::ChessMarkRobot, side)
    if robot.flag == true
        putmarker!(robot)
    end
    move!(robot.robot, side)
    robot.flag = !robot.flag 
    return nothing
end

function HorizonSideRobots.move!(robot::ChessMarkRobot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end
function HorizonSideRobots.move!(robot,side,num_steps::Integer)#integer - любой целый тип
    for _ in 1:num_steps #индекс не нужен, поэтому заменяем на _, при этом цикл включает последний элемент
        move!(robot,side)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function movetoend!(stop_condition::Function, robot::ChessMarkRobot, side) #chess
    step = 0
    while !stop_condition()
        move!(robot,side)
        step += 1
    end
    return step
end

function snake!(stop_condition::Function, robot::ChessMarkRobot, (move_side, next_row_side)::NTuple{2, HorizonSide}=(Ost,Nord))
    s = move_side
    step_nextrowside = 0
    step_moveside = movetoend!(()->stop_condition() || isborder(robot, s), robot,s)
    while !stop_condition()
        movetoend!(()->stop_condition() || isborder(robot, s), robot,s) 
        if stop_condition() 
            break 
        end 
        s = inverse(s) 
        move!(robot, next_row_side)
        step_nextrowside += 1
    end
    movetoend!(()-> isborder(robot, s), robot,s)
    move!(robot, inverse(next_row_side), step_nextrowside)
    move!(getbaserobot(robot), inverse(s), step_moveside)
end

robot = Robot(animate = true)
chessmarkrobot = ChessMarkRobot(robot, 1)
snake!(() -> isborder(chessmarkrobot, Nord), chessmarkrobot, (Ost, Nord))
chessmarkrobot = ChessMarkRobot(robot, 1)
snake!(() -> isborder(chessmarkrobot, Sud), chessmarkrobot, (West, Sud))
