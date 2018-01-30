///handle_undoMove(par_robot robot)

var robot = argument0;

print("handle_undoMove");

if (isDead){ 
    switch(string(object_get_name(robot.object_index))){
        case "obj_player":
            print("objPlayer sprite");
            sprite_index = spr_player;
            break;
        case "obj_roberta":
            print("roberta spr");
            sprite_index = spr_roberta;
            break;
    }
    //sprite_index = spr_player;
    isDead = false;
}

if (!ds_stack_empty(robot.moveHistory)){
    //handle player's undo
    var objPosStr = ds_stack_pop(robot.moveHistory); //string e.g. "64,64"
    print(objPosStr);
    //print(obj_player.x);
    //print(obj_player.y);
    if (objPosStr != undefined){
        var objCoordArr = scr_split(objPosStr);
        //print(objCoordArr[0]);
        //print(objCoordArr[1]);
        robot.x = objCoordArr[0];
        robot.y = objCoordArr[1];
        robot.playerX = robot.x;
        robot.playerY = robot.y;
    }
    //handle player's items on undo
    var items = ds_stack_pop(robot.itemHistory);
    robot.numKeys = items[0];
    
    //handle every element's 
    for (var i = 0; i < array_length_1d(global.roomContents); i++){
        //print("in loop");
        with(global.roomContents[i]){
            //print("key still here");
            //var obj = global.roomContents[i];
            //print(object_get_name(global.roomContents[i]));
            
            if (isSpike){
                var spikeStateStr = ds_stack_pop(stateHistory);
                if (spikeStateStr != undefined){
                    print ("UNDOING SPIK");
                    print(spikeStateStr);
                    var stateArr = scr_split(spikeStateStr);
                    var stateStr = stateArr[0];
                    var stateDir = stateArr[1];
                    print(stateStr);
                    print(stateDir);
                    if (stateStr == "idle"){
                        targetLocked = false;
                        state = "idle";
                        targetDirection = "idling";
                        sprite_index = spr_spike;
                    }
                    else if (stateStr == "active"){
                        targetLocked = true;
                        state = "active";
                        targetDirection = stateDir;
                        sprite_index = spr_spikeActive;
                    }
                }
            }
            if (isFallingPlatform){
                var fallingPlatformStr = ds_stack_pop(stateHistory);
                if (fallingPlatformStr != undefined){
                    print ("UNDOING FALLING PLATFORM");
                    if ((stepsLeft < fallingPlatformStr)){
                        stepsLeft++;
                        image_index--;
                        if (stepsLeft != 0){
                            isDeactivated = false;
                        }
                    }
                }
            }
            if (isArrow){
                if (isRotating){
                    switch(dir){
                        case "up":
                            dir = "left";
                            break;
                        case "right":
                            dir = "up";
                            break;
                        case "down":
                            dir = "right";
                            break;
                        case "left":
                            dir = "down";
                            break;
                    }
                    sprite_index = asset_get_index("spr_arrow_" + dir);
                }
            }
            
            var objPosStr = ds_stack_pop(moveHistory); //string e.g. "64,64"
            //print(objPosStr);
            if (objPosStr != undefined){
                var objCoordArr = scr_split(objPosStr);
                x = objCoordArr[0];
                y = objCoordArr[1];
                if ((instance_place(x, y, par_pullable) || instance_place(x, y, par_robot)) && triggerDoorPtr != undefined){ //this is a trigger being pressed
                    self.triggerDoorPtr.image_index = 1;
                    self.triggerDoorPtr.isDeactivated = true;
                }
                if ((!instance_place(x, y, par_pullable) && !instance_place(x, y, par_robot)) && triggerDoorPtr != undefined){ //this is a trigger not being pressed
                    self.triggerDoorPtr.image_index = 0;
                    self.triggerDoorPtr.isDeactivated = false;
                }
                if (object_get_name(object_index) == "obj_key"){
                    if (deactivatedX != 0 || deactivatedY != 0){
                        //obj_player.numKeys--;
                        isDeactivated = false;
                        print("Key deactivated");
                        deactivatedX = undefined;
                        deactivatedY = undefined;
                    }
                    if (obj_key.x != 0 && obj_key.y !=0){
                        obj_key.image_index = 0;
                    }
                }
            }
        }
    }
}

undo = false;
