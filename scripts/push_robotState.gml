///push_robotState(var robot, bool pushCurState, var pushXVal, var PushYVal)

var robot = argument0;
var pushCurState = argument1; //push previous turn or this current one
var pushXOntoStack = argument2; //default to robot's previous turn
var pushYOntoStack = argument3; //default to robot's previous turn

if (pushCurState){ pushXOntoStack = robot[| OBJECT.X]; pushYOntoStack = robot[| OBJECT.Y]; }

print("-> DISABLED push_robotState(" + string(pushXOntoStack) + "," + string(pushYOntoStack) + ")");

//ds_stack_push(robot.moveHistory, string(room_get_name(room)) + ";" + string(pushXOntoStack) + "," + string(pushYOntoStack));
//ds_stack_push(robot.itemHistory, array(robot.numKeys, robot.hasBaby));
//ds_stack_push(robot.movedDirHistory, robot.movedDir);
print("DID NOT PUSH (currently) " + string(pushXOntoStack) + ", " + string(pushYOntoStack)); 

<<<<<<< HEAD
//robot.oldPlayerX = x;
//robot.oldPlayerY = y;
//robot.x = robot.playerX; 
//robot.y = robot.playerY;

robot[| ROBOT.OLDPOSX] = robot[| OBJECT.X];
robot[| ROBOT.OLDPOSY] = robot[| OBJECT.Y];
robot[| OBJECT.X] = robot[| ROBOT.NEWX]; 
robot[| OBJECT.Y] = robot[| ROBOT.NEWY];

=======
//robot[| ROBOT.OLDPOSX] = robot[| OBJECT.X];
//robot[| ROBOT.OLDPOSX] = robot[| OBJECT.Y];
//robot[| OBJECT.X] = robot.playerX; 
//robot[| OBJECT.Y] = robot.playerY;

>>>>>>> master
if (map_place(self, obj_slideTile, robot[| OBJECT.X], robot[| OBJECT.Y])){
    robot[| ROBOT.CANMOVE] = false;
}
