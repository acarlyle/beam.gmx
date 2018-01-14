///handle_gameMove();

print("handle game move");
var objMove = false;


for (var i = 0; i < array_length_1d(global.roomContents); i++){
    var object = global.roomContents[i];
    with(object){
        if (!justDeactivated){ // ACTUALLY NOT JUST DEACTIVATED !!!
            ds_stack_push(moveHistory, string(x) + "," + string(y)); //pushing previous turn's movement
        }
        else{ 
            justDeactivated = false; 
        }
        //print("Pushed onto object's stack !");
        //print(x); print(y);
        if (global.oldPlayerY == y && obj_player.y == y){ //player moved left/right
            if (obj_player.x < x && scr_canPull(x - 16, y, false)) {//player on left side of object 
                x -= 16;
                objMove = true;
            }
            else if (obj_player.x > x && scr_canPull(x + 16, y, false)){//player on right side of object
                x += 16;
                objMove = true;
            }
        }
        if (global.oldPlayerX == x && obj_player.x == x){ //player moved up/down
            //print("let's pull this shit");
            if (obj_player.y < y && scr_canPull(x, y - 16, false)){ //player above object 
                y -= 16;
                objMove = true;
                //print("pulling");
            }
            else if (obj_player.y > y && scr_canPull(x, y + 16, false)){//player below object 
                y += 16;
                objMove = true;
            }
        }
        var objRelYPos = 1;
        var objRelXPos = -1;
        if (obj_player.y < y) objRelYPos *= -1;
        if (obj_player.x > x) objRelXPos *= -1;
        //print(objRelXPos)
        
        var xDiff = obj_player.x - global.oldPlayerX;
        var yDiff = obj_player.y - global.oldPlayerY;
        var newObjPosX = 0; 
        var newObjPosY = 0;
        
        if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right
                //print("up and to the right");
                newObjPosX = x + 16;
                newObjPosY = y - 16;
        }
        if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left
                newObjPosX = x - 16;
                newObjPosY = y - 16;
        }
        if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right
                newObjPosX = x + 16;
                newObjPosY = y + 16;
        }
        if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left
                newObjPosX = x - 16;
                newObjPosY = y + 16;
        }
        
        //print("hur-----");
        //print(obj_player.x)
        //print(obj_player.y)
        //print(global.oldPlayerX);
        //print(global.oldPlayerY);
        //print(newObjPosX);
        //print(newObjPosY);
        //print("-----dur");
        
        
        if (!objMove  
            && (obj_player.x - global.oldPlayerX != 0) 
            && (obj_player.y - global.oldPlayerY != 0) 
            && scr_canPull(newObjPosX, newObjPosY, true)
            && abs((obj_player.y - y) / (obj_player.x - x)) == 1
            && abs((global.oldPlayerY - y) / (global.oldPlayerX - x)) == 1){
                
            print("diag time baby");
            //print(obj_player.x - global.oldPlayerX);
            //print(obj_player.y - global.oldPlayerY);
            
            if (obj_player.y < y && obj_player.x > x){ //player is above the obj and to the right
                x += 16;
                y -= 16;
            }
            if (obj_player.y < y && obj_player.x < x){ //player is above the obj and to the left
                x -= 16;
                y -= 16; 
            }
            if (obj_player.y > y && obj_player.x > x){ //player is below the obj and to the right
                x += 16;
                y += 16; 
            }
            if (obj_player.y > y && obj_player.x < x){ //player is below the obj and to the left
                x -= 16;
                y += 16;
            }
            objMove = true;
        }
        if ((instance_place(x, y, obj_block) || instance_place(x, y, obj_player)) && triggerDoorPtr != undefined){ //this is a trigger being pressed
            object.triggerDoorPtr.image_index = 1;
            object.triggerDoorPtr.isDeactivated = true;
            print("trigger pressed; trigger door is deactivated");
        }
        if ((!instance_place(x, y, obj_block) && !instance_place(x, y, obj_player)) && triggerDoorPtr != undefined){ //this is a trigger not being pressed
            object.triggerDoorPtr.image_index = 0;
            object.triggerDoorPtr.isDeactivated = false;
            print("WARNING!!! TRIGGER DOOR ACTIVATED");
            if (instance_place(obj_player.x, obj_player.y, obj_triggerDoor)){
                //obj_player.isDead = true; //:(
                //obj_player.sprite_index = spr_playerDead;
            } 
        }
        if (!objMove && canFall && instance_place(x, y, obj_hole)){
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
        else if (!instance_place(x, y, obj_hole) && canFall){
            sprite_index = spr_key;
            //print("no hole");
        }
        else if(instance_place(x, y, obj_hole) && canFall){
            //print("HOLE");
            sprite_index = spr_keyFloating;
            image_speed = .3;
        }
    }
}

moved = false;
