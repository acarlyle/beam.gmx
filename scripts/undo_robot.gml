///undo_robot(par_robot robot)

/*
    Handles undo for this robot obj
    moveHistory     -> "roomName;0,0" #Name;objPosX,objPosY
    itemHistory     -> var numKeys, bool hasBaby 
    movedDirHistroy -> str direction
*/

robot = argument0;

print("-> undo_robot");

//handle this robot's undo
var movementStr = ds_stack_pop(robot[| OBJECT.MOVEHISTORY]); //string e.g. "64,64"
//print(movementStr);
    
//handle this robot's items on undo
var items = ds_stack_pop(robot[| ROBOT.ITEMHISTORY]);
if (items != undefined)
{
    robot[| ROBOT.NUMKEYS] = items[0];
    robot[| ROBOT.HASBABY] = items[1];
}
    
robot[| OBJECT.MOVEDDIR] = ds_stack_pop(robot[| OBJECT.MOVEDDIRHISTORY]);
if (movementStr != undefined){
    var moveArrComponents = scr_split(movementStr, ";");
    var objPosArr = scr_split(moveArrComponents[1], ",");
    var rmName = moveArrComponents[0];
    //print("NAME!!!!: " + string(rmName));
    if rmName != room_get_name(room){
        handle_gotoRoom(scr_roomFromString(rmName), "undoRoom");
        return false; //switch to other room 
    }
    
    robot[| OBJECT.X] = objPosArr[0];
    robot[| OBJECT.Y] = objPosArr[1];
    robot[| ROBOT.NEWX] = robot[| OBJECT.X];
    robot[| ROBOT.NEWY] = robot[| OBJECT.Y];
}
return true; //continue to undo objects
