///scr_mirptrTele(obj_enum enum, par_robot robot)

var layer = argument0;
var object = argument1;
var robot = argument2;
var pushPull = argument3; //whether to push or pull

var objMove = false;

/*print("-> scr_mirptrTele(" + string(objPosX) + ", " + string(objPosY) + ")");

//TODO this whole script lel

//the obj moved onto a mirptr. 
//now obj should teleport to its mirptrPtr (already confirmed can push/pull past its mirptrPtr)
if (map_place(layer, obj_mirptr, object[| OBJECT.X], object[| OBJECT.Y])){ 
    var mirptr = map_place(layer, obj_mirptr, object[| OBJECT.X], object[| OBJECT.Y]);
    if (robot.oldPlayerY == objPosY && robot.y == objPosY){ //player moved left/right
        object[| OBJECT.X] = mirptr.mirptrPtr.x;
        object[| OBJECT.Y] = mirptr.mirptrPtr.y;
        if (robot.x < objPosX) {//player on left side of object 
            if (robot.x != object[| OBJECT.X] - (global.TILE_SIZE*pushPull)){ 
                x -= (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object[| OBJECT.Y] = mirptr.y;
                return false;
            }
        }
        else if (robot.x > objPosX){//player on right side of object
            if (robot.x != object[| OBJECT.X] + (global.TILE_SIZE*pushPull)){ 
                x += (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object[| OBJECT.Y] = mirptr.y;
                return false;
            }
        }
    }
    if (robot.oldPlayerX == objPosX && robot.x == objPosX){ //player moved up/down
        object[| OBJECT.X] = mirptr.mirptrPtr.x;
        object[| OBJECT.Y] = mirptr.mirptrPtr.y;
        if (robot.y < objPosY){ //player above object
            if (robot.y != object[| OBJECT.Y] - (global.TILE_SIZE*pushPull)){ 
                y -= (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object[| OBJECT.X] = mirptr.x;
                return false;
            }
        }
        else if (robot.y > objPosY){ //player below object 
            if (robot.y != object[| OBJECT.Y] + (global.TILE_SIZE*pushPull)){
                y += (global.TILE_SIZE*pushPull);
                objMove = true;
            }
            else{
                object[| OBJECT.X] = mirptr.x;
                return false;
            }
        }
    }
    return true;
}
else return true;*/

return false;
