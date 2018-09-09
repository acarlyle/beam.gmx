///handle_layerRobots(obj_layer layer, par_robot robot);

var layer = argument0;

var robot = layer.robot;

handle_deployBaby(layer, robot);  //this handles baby placement if player pressed space and has a Baby on Board

//if on a slideTile, disable player input keys
if (map_place(layer, obj_slideTile, robot[| OBJECT.X], robot[| OBJECT.X])){
    baby[| OBJECT.STATE] = "tile_slide";
}

var pushXOntoStack = robot[| OBJECT.OLDPOSX];
var pushYOntoStack = robot[| OBJECT.OLDPOSY];


switch(robot[| OBJECT.STATE]){
    case "tile_one": //normal state; robot moves one tile at a time
        handle_robotMove_tile_one(layer, robot);
        break;
    case "tile_slide": //robot is sliding across some ice, cannot control direction
        handle_robotMove_tile_slide(layer, robot);
        break;
}

if (!robot[| OBJECT.MOVED] && !robot[| ROBOT.ISDEAD]){ //if we didn't move and we aren't dead
    handle_checkForStairs(layer, robot);
    if (!global.switchRooms) { //we aren't switching rooms
        handle_checkLowerRoom(layer, robot);
    }
}

if (robot[| OBJECT.MOVED]){
    
    handle_checkForRoomTransition(layer, robot);
    
    if (robot[| OBJECT.NAME] == "obj_player" && robot[| OBJECT.MOVED]){
        global.playerMoved = true;
    }
    
    if (global.playerMoved){ //TODO add stack functionaly with layers
        push_robotState(robot, false, pushXOntoStack, pushYOntoStack);
        
        //update Robot position vars
        robot[| OBJECT.OLDPOSX] = robot[| OBJECT.X];
        robot[| OBJECT.OLDPOSY] = robot[| OBJECT.Y];
        robot[| OBJECT.X] = robot[| ROBOT.NEWX]; 
        robot[| OBJECT.Y] = robot[| ROBOT.NEWY];
        
        print("handle_layerRobots: PLAYER MOVED TO: " + string(robot[| OBJECT.X]) +"," + string(robot[| OBJECT.Y]));
        
    }
    else{
        robot[| OBJECT.MOVEDDIR] = "";
    }
    
    // Now update this layer's position with moved Robot
    
    layer_updateObjAtTile(layer, robot, pushXOntoStack, pushYOntoStack); //pass old positions
    
    //TODO need better method of main layer checking 
    if (robot[| OBJECT.NAME] == "obj_player"){
        var objInst = instance_place(robot[| OBJECT.OLDPOSX], robot[| OBJECT.OLDPOSY], get_objectFromString(robot[| OBJECT.NAME]));
        //var objInst = instance_place(48, 128, obj_player);
        objInst.x = robot[| OBJECT.X];
        objInst.y = robot[| OBJECT.Y];
    }
    
}

layer.move = false;
robot[| ROBOT.CANMOVE] = true;
robot[| OBJECT.STATE] = "tile_one"; //reset state to default movement 
