///scr_tileContains(obj_layer layer, var objPosX, var objPosY, array objectList[])

/*
    Script returns true if the tile specified by the args objPosX and objPosY
    contain one of the objects passed in the objectList.  Otherwise, returns
    false.
*/

var layer = argument0;
var objPosX = argument1;
var objPosY = argument2;
var objectList = argument3; //objects we want to see if the Tile contains

print("scr_tileContains: xPos " + string(objPosX));
print("scr_tileContains: YPos " + string(objPosY));

//print("scr_tileContains: layer x bound: " + string(layer.xBound));
//print("scr_tileContains: layer y bound: " + string(layer.yBound));

//if ((objPosY > 200 || objPosY <= 0) || (objPosX > 200 || objPosX <= 0)){
//    print("WARNING WAY THE FUCK OUT OF WHILE LOOP BOUNDS in (par script, now in scr_tileContains)");
//    return true; //hardcoded to prevent infinite loop
//}

//var objsAtTile = layer.roomMapArr[(real(objPosY))/global.TILE_SIZE, (real(objPosX))/global.TILE_SIZE]

for (var i = 0; i < array_length_1d(objectList); i++){
    var object = objectList[i];
    //if (((abs(objPosX / global.DEACTIVATED_X)) >= layer.xBound) || ((abs(objPosY / global.DEACTIVATED_Y)) >= layer.yBound)){
    //    print("scr_tileContains: Warning!!  Out of bounds check.");
    //    return true; //HARDCODED to prevent out of bounds check in mapArr
    //}
    if (map_place(layer, object, objPosX, objPosY)){
        var obj = map_place(layer, object, objPosX, objPosY);
        //if (!instance_exists(obj)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, obj);
        //print("scr_tileContains: checking for obj " + string(object_get_name(obj)));
        if (!isEnum(obj)) return true; //if it's not an enum, it's probably a wall or something.  we can't check ISACTIVE
        if obj[| OBJECT.ISACTIVE]{ //if object is actively in place
            return true;
        }
    }
}

return false;
