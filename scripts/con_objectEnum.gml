///con_objectEnum(str objName, int objPosX, int objPosY)

var objName = argument0;
var objPosX = argument1;
var objPosY = argument2;

var objectEnum = ds_list_create();

print("-> con_objectEnum of: " + string(objName));

objectEnum[| OBJECT.NAME] = objName;
objectEnum[| OBJECT.MOVED] = false;
objectEnum[| OBJECT.MOVEDDIR] = "";
objectEnum[| OBJECT.X] = real(objPosX);
objectEnum[| OBJECT.Y] = real(objPosY);
objectEnum[| OBJECT.STATE] = "";
objectEnum[| OBJECT.ISACTIVE] = true;
objectEnum[| OBJECT.FOODCHAIN] = 0;
objectEnum[| OBJECT.ISSTEPPINGSTONE] = false;
objectEnum[| OBJECT.OLDPOSX] = real(objPosX);
objectEnum[| OBJECT.OLDPOSY] = real(objPosY);
objectEnum[| OBJECT.IMGIND] = 0;


/*  
    Probably best not to store every possible variable in a text file.
    something like the below would be much better for loading in object-specific
    variables.  For variables that can be changed based on position/context,
    those for sure should be stored somewhere.  
*/

switch(get_objectFromString(objName)){
    case obj_arrow_down_rotate:
        objectEnum[| ARROW.DIR] = "down";
        objectEnum[| ARROW.ISROTATING] = true;
        objectEnum[| OBJECT.IMGIND] = 2;
        break;
    case obj_arrow_down_static:
        objectEnum[| ARROW.DIR] = "down";
        objectEnum[| ARROW.ISROTATING] = false;
        objectEnum[| OBJECT.IMGIND] = 2;
        break;
    case obj_arrow_left_rotate:
        objectEnum[| ARROW.DIR] = "left";
        objectEnum[| ARROW.ISROTATING] = true;
        objectEnum[| OBJECT.IMGIND] = 3;
        break;
    case obj_arrow_left_static:
        objectEnum[| ARROW.DIR] = "left";
        objectEnum[| ARROW.ISROTATING] = false;
        objectEnum[| OBJECT.IMGIND] = 3;
        break;
    case obj_arrow_right_rotate:
        objectEnum[| ARROW.DIR] = "right";
        objectEnum[| ARROW.ISROTATING] = true;
        objectEnum[| OBJECT.IMGIND] = 1;
        break;
    case obj_arrow_right_static:
        objectEnum[| ARROW.DIR] = "right";
        objectEnum[| ARROW.ISROTATING] = false;
        objectEnum[| OBJECT.IMGIND] = 1;
        break;
    case obj_arrow_up_rotate:
        objectEnum[| ARROW.DIR] = "up";
        objectEnum[| ARROW.ISROTATING] = false;
        objectEnum[| OBJECT.IMGIND] = 0;
        break;
    case obj_arrow_up_static:
        objectEnum[| ARROW.DIR] = "up";
        objectEnum[| ARROW.ISROTATING] = false;
        objectEnum[| OBJECT.IMGIND] = 0;
        break;
    case obj_block:
        objectEnum[| OBJECT.CANPULL] = true;
        objectEnum[| OBJECT.CANPUSH] = false;
        objectEnum[| OBJECT.ISSTEPPINGSTONE] = true;
        break;
    case obj_blockPush:
        objectEnum[| OBJECT.CANPULL] = false;
        objectEnum[| OBJECT.CANPUSH] = true;
        objectEnum[| OBJECT.ISSTEPPINGSTONE] = true;
        break;
    case obj_blockPushPull:
        objectEnum[| OBJECT.CANPULL] = true;
        objectEnum[| OBJECT.CANPUSH] = true;
        objectEnum[| OBJECT.ISSTEPPINGSTONE] = true;
        break;
    case obj_door:
        objectEnum[| DOOR.ISLOCKED] = true;
        objectEnum[| OBJECT.ISSTEPPINGSTONE] = true;
        break; 
    case obj_fallingPlatform_1Step:
        objectEnum[| PLATFORM.STEPSLEFT] = 1;
        objectEnum[| OBJECT.IMGIND] = 1;
        break;
    case obj_fallingPlatform_2Step:
        objectEnum[| PLATFORM.STEPSLEFT] = 2;
        objectEnum[| OBJECT.IMGIND] = 2;
        break;  
    case obj_fallingPlatform_3Step:
        objectEnum[| PLATFORM.STEPSLEFT] = 3;
        objectEnum[| OBJECT.IMGIND] = 3;
        break;    
    case obj_key:
        objectEnum[| OBJECT.CANPULL] = true;
        objectEnum[| OBJECT.STATE] = "grounded";
        break;
    case obj_magneticSnare:
        objectEnum[| OBJECT.CANPULL] = true;
        break;
    case obj_player:
        objectEnum[| OBJECT.CANPULL] = false;
        objectEnum[| OBJECT.CANPUSH] = false;
        objectEnum[| OBJECT.STATE] = "tile_one";
        
        objectEnum[| ROBOT.CANMOVE] = true;
        objectEnum[| ROBOT.ISDEAD] = false;
        objectEnum[| ROBOT.NUMKEYS] = 0;
        objectEnum[| ROBOT.HASBABY] = false;
        objectEnum[| ROBOT.NEWX] = real(objPosX);
        objectEnum[| ROBOT.NEWY] = real(objPosY);
        objectEnum[| OBJECT.ISSTEPPINGSTONE] = true;
        break;
    case obj_spike:
        objectEnum[| OBJECT.CANPULL] = true;
        objectEnum[| OBJECT.STATE] = "idling";
        objectEnum[| OBJECT.FOODCHAIN] = 1;
        objectEnum[| AI.TARGETLOCKED] = false;
        break;
    case obj_trigger:
        objectEnum[| TRIGGER.TRIGGERPTR] = undefined;
        objectEnum[| TRIGGER.DOORPTR] = undefined;
        
        //for (var o = 0; o <= ds_list_size(objectEnum); o++){
        //    print("Yaar: " + string(objectEnum[| o]));
        //} 
        
        break;
    case obj_triggerDoor:
        objectEnum[| TRIGGER.TRIGGERPTR] = undefined;
        objectEnum[| TRIGGER.DOORPTR] = undefined;
        //objectEnum[| OBJECT.OLDPOSX] = undefined;
        //objectEnum[| OBJECT.OLDPOSY] = undefined;
        //print("Con_triggerDoor X: " + string(objectEnum[| OBJECT.X]));
        //print("Con_triggerDoor Y: " + string(objectEnum[| OBJECT.Y]));
        break;
}

return objectEnum;
