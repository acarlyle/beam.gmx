///scr_canPullPush(int objPosX, int objPosY, bool moveDiag)

if (!(canPull || canPush)) return false;
if (isDeactivated) return false;

//print(argument0);
//print(argument1);

if (instance_place(x, y, obj_triggerDoor) && !instance_place(argument0, argument1, obj_wall)){
    //print("obj trapped above");
    return false; //can't move if above
}

if (!instance_place(argument0, argument1, par_platform)){
    //print("No platform to pull/push to");
    return false;
}

//key parsing
/*if (isDeactivated == true && (canPull || canPush)){
    if (x != 0 && y != 0){
        print("Not deactivated anymore");
        isDeactivated = false;
        //obj_player.numKeys--;
    }
    else{
        print("Obj deactivated"); 
        return false; //do not pull this object
    }
}*/

if (instance_place(argument0, argument1, obj_spike)){
    //print("Spike in the way!");
    return false;
}
if (instance_place(argument0, argument1, obj_block)){
    //print("Block in the way!");
    return false;
}
if (instance_place(argument0, argument1, obj_key)){
    //print("Key in the way!");
    return false;
}

if (instance_place(argument0, argument1, obj_trigger)){
    //print("There's a trigger here.");
    return true;
}
if (instance_place(argument0, argument1, obj_triggerDoor)){
    //print("There's a triggerDoor here.");
    var triggerDoor = instance_place(argument0, argument1, obj_triggerDoor);
    if (triggerDoor.isDeactivated) return true;
    return false;
}

if (instance_place(argument0, argument1, obj_player) && !isSpike){
    print("Can't move, player in the way");
    //print(string(argument0)); print(string(argument1)); print(string(obj_player.x)); print(string(obj_player.y));
    //print(string(global.oldPlayerX)); print(string(global.oldPlayerY));
    return false; //there's a player here!!  don't move!
}
if (instance_place(argument0, argument1, obj_hole)){
    //print("Can't move, hole in the way");
    if (!canFall) return false; //there's a hole here!!  don't move unless you can go over holes!
}

if (isSpike){
    if (instance_place(argument0, argument1, par_obstacle)){
        print("SPIKE STOPPED BY OBSTACLE!!!!");
        return false;
    }
    else return true;
}

//print("this far...");

var xDiff = obj_player.x - x;
var yDiff = obj_player.y - y;

if (!argument2 && canPull && !canPush){ //this checks left/right only

    if (yDiff == 0){ //player is moving left/right; check for objects towards the player
        if (xDiff > 0){ //player is to the right of the obj
            for (var objX = x + global.TILE_SIZE; objX < obj_player.x; objX += global.TILE_SIZE){
                if (instance_place(objX, y, par_obstacle)){
                    var obs = instance_place(objX, y, par_obstacle);
                    if (isActivated(obs)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
        }
        else{ //player is to the left of the obj
            for (var objX = x - global.TILE_SIZE; objX > obj_player.x; objX -= global.TILE_SIZE){
                if (instance_place(objX, y, par_obstacle)){
                    var obs = instance_place(objX, y, par_obstacle);
                    if (isActivated(obs) && !instance_place(objX, y, obj_snare)){
                        print(objX);
                        print("something i nthe way");
                        print(isDeactivated);
                        return false; //don't pull if anything is in the way
                    }
                }
            }
        }
    }
    if (xDiff == 0){ //player is moving up/down; check for objects towards the player
        if (yDiff < 0){ //player is above the obj
            for (var objY = y - global.TILE_SIZE; objY > obj_player.y; objY -= global.TILE_SIZE){
                if (instance_place(x, objY, par_obstacle)){
                    var obs = instance_place(x, objY, par_obstacle);
                    //print("isDeactived?");
                    if (isActivated(obs)){
                        return false; //don't pull if anything is in the way
                    }
                }
            }
        }
        else{ //player is below the obj
            for (var objY = y + global.TILE_SIZE; objY < obj_player.y; objY += global.TILE_SIZE){
                if (instance_place(x, objY, par_obstacle)){
                    var obs = instance_place(x, objY, par_obstacle);
                    //print(obs.isDeactivated);
                    if (!obs.isDeactivated){
                        print("oh no it is activated");
                        return false; //don't pull if anything is in the way
                    }
                }
            }
        }
    }
}

//diagonal movement
if (argument2 == true && canPull && !canPush){
    print("Diag checking in scr_canPull");
    if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right; pull object upright
        //print("pull object up right");
        var objX = x+global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x + global.TILE_SIZE; objX < obj_player.x; objX += global.TILE_SIZE){
            //print("In that upright loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= global.TILE_SIZE;  
        }
    }
    if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left; pull object upleft
        //print("pull object up left");
        var objX = x-global.TILE_SIZE; var objY = y-global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x - global.TILE_SIZE; objX > obj_player.x; objX -= global.TILE_SIZE){
            //print("In that left loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY -= global.TILE_SIZE;  
        }
    }
    if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right; pull object downright
        //print("pull object down right");
        var objX = x + global.TILE_SIZE; var objY = y + global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x + global.TILE_SIZE; objX < obj_player.x; objX += global.TILE_SIZE){
            //print("In that downright loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += global.TILE_SIZE;  
        }          
    }
    if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left; pull object downleft
        //print("pull object down left");
        var objX = x-global.TILE_SIZE; var objY = y+ global.TILE_SIZE;
        //print(objX);
        //print(objY);
        for (objX = x - global.TILE_SIZE; objX > obj_player.x; objX -= global.TILE_SIZE){
            //print("In that downleft loop !");
            //print(objX);
            //print(objY);  
            if (instance_place(objX, objY, par_obstacle)) return false; //don't pull if anything is in the way
            objY += global.TILE_SIZE;  
        }    
    }   
}



        



return true;
