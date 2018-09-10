 ///move_pullPushables(obj_layer layer, obj_enum object)

/*
    This function handles:
        obj_block
        obj_blockPush
        obj_blockPushPull
        obj_key
        obj_magneticSnare
*/

var layer = argument0;
var object = argument1;



var pushPull = 1;

var mirptrExt = false; // if a mirptr is in the objects push/pull path
var mirptrVt = false;
var mirptrHz = false;
var object_state = "tile_one"; //default movement, TODO should read from file

//if (scr_roomContains(

//object.moved = false; 
//object.state = "tile_one";

//TODO -> Mirraporter logic w/ 2d array
/*with (obj_mirptr){
    
    var mirptr = self;
    var mirptrPtr = self.mirptrPtr;
    if ((mirptr.x == object.x && (robot.oldPlayerX == mirptrPtr.x || robot[| OBJECT.X] == mirptrPtr.x)) &&
        (robot[| OBJECT.Y] - robot.oldPlayerY != 0)){ //checks to see if player actually moved up/down
        //print("NSYNC!!!! VT");
        object_posX = mirptrPtr.x;
        object_posY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrVt = true;
    }
    if ((mirptr.y == object.y && (robot.oldPlayerY == mirptrPtr.y || robot[| OBJECT.Y] == mirptrPtr.y)) &&
        (robot[| OBJECT.X] - robot.oldPlayerX != 0)){ //checks to see if player actually moved left/right
        //print("NSYNC!!!! HZ");
        object_posX = mirptrPtr.x;
        object_posY = mirptrPtr.y;
        //mirptrExt = true;
        mirptrExt = mirptr;
        mirptrHz = true;
    }
}*/

if (map_place(layer, obj_slideTile, object[| OBJECT.X], object[| OBJECT.Y])){
    object_state = "tile_slide";
}

switch(object_state){
    case "tile_one":
        move_pullPushables_tile_one(layer, object, mirptrExt, mirptrHz, mirptrVt, pushPull); //default one tile grid movement
        break;
    case "tile_slide":
        move_pullPushables_tile_slide(layer, object, mirptrExt, mirptrHz, mirptrVt, pushPull); //if an object is sliding (on ice or something)
        break;
}

if (object[| OBJECT.MOVED]){
    audio_play_sound(snd_blockDrag, 10, false);
}
