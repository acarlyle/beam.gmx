///handle_playerMove(par_robot robot);

var robot = argument0;

handle_deployBaby(robot);  //this handles baby placement if player pressed space and has a Baby on Board

//if on a slideTile, disable player input keys
if (instance_place(robot.x, robot.y, obj_slideTile)){
    robot.state = "tile_slide";
}

var pushXOntoStack = robot.playerX;
var pushYOntoStack = robot.playerY;


switch(robot.state){
    case "tile_one": //normal state; robot moves one tile at a time
        handle_robotMove_tile_one(robot);
        break;
    case "tile_slide": //robot is sliding across some ice, cannot control direction
        handle_robotMove_tile_slide(robot);
        break;
}

if (robot.moved){
    
    handle_checkForRoomTransition(robot);
    
    if (object_get_name(robot.object_index) == "obj_player" && robot.moved){
        global.playerMoved = true;
        print("PLAYER MOVED");
    }
    
    if (global.playerMoved){ 
        push_robotState(robot, false, pushXOntoStack, pushYOntoStack);
    }
    else{
        robot.movedDir = "";
    }
}
else{ //if we didn't move
    handle_checkForStairs(robot);
}
robot.move = false;
robot.canMove = true;
robot.state = "tile_one"; //reset state to default movement 
