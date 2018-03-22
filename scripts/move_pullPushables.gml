 ///move_pullPushables(obj object, par_robot robot)

/*
    This function handles:
    obj_block
    obj_blockPush
    obj_blockPushPull
    obj_key
*/

var object = argument0;
var robot = argument1;

var objMove = false; 
var pushPull = 1;

var objPosX = object.x;
var objPosY = object.y;

var mirptrExt = false; // if a mirptr is in the objects push/pull path
var mirptrVt = false;
var mirptrHz = false;

print("oldPlayerX: " + string(robot.oldPlayerX));

with (obj_mirptr){
    
    var mirptr = self;
    var mirptrPtr = self.mirptrPtr;
    print("mirptrPTr x: " + string(mirptrPtr.x));
    //up/down sync
    //if ((mirptr.x == object.x && robot.x == mirptrPtr.x) &&
    if ((mirptr.x == object.x && (robot.oldPlayerX == mirptrPtr.x || robot.x == mirptrPtr.x)) &&
        (robot.y - robot.oldPlayerY != 0)){ //checks to see if player actually moved up/down
        print("NSYNC!!!! VT");
        objPosX = mirptrPtr.x;
        objPosY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrVt = true;
    }
    //if ((mirptr.y == object.y && robot.y == mirptrPtr.y) &&
    if ((mirptr.y == object.y && (robot.oldPlayerY == mirptrPtr.y || robot.y == mirptrPtr.y)) &&
        (robot.x - robot.oldPlayerX != 0)){ //checks to see if player actually moved left/right
        print("NSYNC!!!! HZ");
        objPosX = mirptrPtr.x;
        objPosY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrHz = true;
    }
}

print("move_pullPushables objPosX/Y: " + string(objPosX) + ", " + string(objPosY));


//figure out which way to push/pull
if (canPush && canPull){
    if (robot.y - robot.oldPlayerY > 0){ //player moved down
        if (objPosY > robot.y) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX > 0){ //player moved right
        if (objPosX > robot.x) pushPull *=-1;
    }
    if (robot.x - robot.oldPlayerX < 0){ //player moved left
        if (objPosX < robot.x) pushPull *=-1;
    }
    if (robot.y - robot.oldPlayerY < 0){ //player moved up
        if (objPosY < robot.y) pushPull *=-1;
    }
}
//push only
else if (canPush) pushPull *= -1;
if ((robot.oldPlayerY == objPosY && robot.y == objPosY) || (!mirptrVt && mirptrHz)){ //player moved left/right
    print("push/pull left/right");
    //print(x - (global.TILE_SIZE*pushPull));
    if (robot.x < objPosX && scr_canPullPush(objPosX - (global.TILE_SIZE*pushPull), objPosY, false, object, robot, mirptrExt)) {//player on left side of object 
        x -= (global.TILE_SIZE*pushPull);
        print("push/pull left");
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            objMove = true;
        }
        else{
            x += (global.TILE_SIZE*pushPull);    
        }
    }
    else if (robot.x > objPosX && scr_canPullPush(objPosX + (global.TILE_SIZE*pushPull), objPosY, false, object, robot, mirptrExt)){//player on right side of object
        x += (global.TILE_SIZE*pushPull);
        print("push/pull right");
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            objMove = true;
        }
        else{
            x -= (global.TILE_SIZE*pushPull);    
        }
    }
}
print("OldplYaerX: " + string(robot.oldPlayerX) + "; Robot.x: " + string(robot.x) + "; objPosX: " + string(objPosX));
if ((robot.oldPlayerX == objPosX && robot.x == objPosX) || (mirptrVt && !mirptrHz)){ //player moved up/down
    print("push/pull up/down");
    if (robot.y < objPosY && scr_canPullPush(objPosX, objPosY - (global.TILE_SIZE*pushPull), false, object, robot, mirptrExt)){ //player above object 
        y -= (global.TILE_SIZE*pushPull);
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            objMove = true;
        }
        else{
            y += (global.TILE_SIZE*pushPull);    
        }
    }
    else if (robot.y > objPosY && scr_canPullPush(objPosX, objPosY + (global.TILE_SIZE*pushPull), false, object, robot, mirptrExt)){//player below object 
        print("push/pull updown");
        y += (global.TILE_SIZE*pushPull);
        if (scr_mirptrTele(object, robot, pushPull, objPosX, objPosY)){
            print("Moved to: " + string(x) + " " + string(y));
            objMove = true;
        }
        else{
            y -= (global.TILE_SIZE*pushPull);
        }
    }
}
var objRelYPos = 1;
var objRelXPos = -1;
if (robot.y < objPosY) objRelYPos *= -1;
if (robot.x > objPosX) objRelXPos *= -1;
//print(objRelXPos)

var xDiff = robot.x - robot.oldPlayerX;
var yDiff = robot.y - robot.oldPlayerY;
var newObjPosX = 0; 
var newObjPosY = 0;

if (canPull && canPush){
    if (robot.y < objPosY && robot.x > objPosX){ //player is above the obj and to the right
        //print("up and to the right");
        if (xDiff < 0) pushPull *= -1;
    }
    if (robot.y < objPosY && robot.x < objPosX){ //player is above the obj and to the left
        if (xDiff > 0) pushPull *=-1;
    }
    if (robot.y > objPosY && robot.x > objPosX){ //player is below the obj and to the right
        if (yDiff < 0) pushPull *=-1;
    }
    if (robot.y > objPosY && robot.x < objPosX){ //player is below the obj and to the left
        if (yDiff < 0) pushPull *=-1;
    }
}

if (robot.y < objPosY && robot.x > objPosX){ //player is above the obj and to the right
//print("up and to the right");
    newObjPosX = objPosX + (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY - (global.TILE_SIZE * pushPull);
}
if (robot.y < objPosY && robot.x < objPosX){ //player is above the obj and to the left
    newObjPosX = objPosX - (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY - (global.TILE_SIZE * pushPull);
}
if (robot.y > objPosY && robot.x > objPosX){ //player is below the obj and to the right
    newObjPosX = objPosX + (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY + (global.TILE_SIZE * pushPull);
}
if (robot.y > objPosY && robot.x < objPosX){ //player is below the obj and to the left
    newObjPosX = objPosX - (global.TILE_SIZE * pushPull);
    newObjPosY = objPosY + (global.TILE_SIZE * pushPull);
}

if (!objMove  
    && (robot.x - robot.oldPlayerX != 0) 
    && (robot.y - robot.oldPlayerY != 0) 
    && scr_canPullPush(newObjPosX, newObjPosY, true, object, robot, mirptrExt)
    && abs((robot.y - objPosY) / (robot.x - objPosX)) == 1
    && abs((robot.oldPlayerY - objPosY) / (robot.oldPlayerX - objPosX)) == 1){
    
    if (robot.y < objPosY && robot.x > objPosX){ //player is above the obj and to the right
        x += (global.TILE_SIZE * pushPull);
        y -= (global.TILE_SIZE * pushPull);
    }
    if (robot.y < objPosY && robot.x < objPosX){ //player is above the obj and to the left
        x -= (global.TILE_SIZE * pushPull);
        y -= (global.TILE_SIZE * pushPull); 
    }
    if (robot.y > objPosY && robot.x > objPosX){ //player is below the obj and to the right
        x += (global.TILE_SIZE * pushPull);
        y += (global.TILE_SIZE * pushPull); 
    }
    if (robot.y > objPosY && robot.x < objPosX){ //player is below the obj and to the left
        x -= (global.TILE_SIZE * pushPull);
        y += (global.TILE_SIZE * pushPull);
    }
    objMove = true;
}

if (objMove){
    audio_play_sound(snd_blockDrag, 10, false);
}

/*if (!objMove && canFall && instance_place(x, y, obj_hole)){
    //print("and this object falls down");
    sprite_index = spr_key;
    isDeactivated = true;
    justDeactivated = true;
    deactivatedX = x;
    deactivatedY = y;
    ds_stack_push(moveHistory, string(x) + "," + string(y));
    x = 0;
    y = 0;
}
//else if (!instance_place(x, y, obj_hole) && canFall){
//    sprite_index = spr_key;
//    //print("no hole");
//}
else if(instance_place(x, y, obj_hole) && canFall){
    //print("HOLE");
    sprite_index = spr_keyFloating;
    image_speed = .3;
}*/
