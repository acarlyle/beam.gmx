///scr_initRoomFromFile(var roomName)

var roomName = argument0;
var fileName = string(roomName) + ".sav";

print(" -> initRoomFromFile");

with (all){if (isPuzzleElement) instance_destroy();}

saveFile = file_text_open_read(fileName);
var curLine = "";

curLine = file_text_readln(saveFile); // *****
curLine = file_text_readln(saveFile); // ---
curLine = file_text_readln(saveFile); // ((roomName))
curLine = file_text_readln(saveFile); // ---

print(curLine);

/*
    !!! Split Breakdown Showdown !!!
    
    | - seperates tiles
    ; - seperates objects in a tile
    : - seperates an object and its multiple stacks
    , - seperates each stack
    _ - seperates a stack type from the stack itself 
    
*/

curLine = file_text_readln(saveFile); //beging room parsing here

while(!strcontains(curLine, "---")){
    
    var tileArr = scr_split(curLine, "|"); //array of each tile's contents
    for (var tile = 0; tile < array_length_1d(tileArr); tile++){
        if (tileArr[tile] == " ") continue; //blank tile
        var objsArr = scr_split(tileArr[tile], ";");
        for (var obj = 0; obj < array_length_1d(objsArr); obj++){
            if (strcontains(objsArr[obj], ":")){ //contains stacks
                print(objsArr[obj]);
                thisObjAndStacks = scr_split(objsArr[obj], ":"); 
                var objName = thisObjAndStacks[0];
                var objRef = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, asset_get_index(objName));
                print(object_get_name(objRef));
                //print(thisObjAndStacks[1]);
                var arrayOfStacks = scr_split(thisObjAndStacks[1], ",");
                
                for (var stack = 0; stack < array_length_1d(arrayOfStacks); stack++){
                    print(arrayOfStacks[stack]);
                    var stackNameAndStackHashArr = scr_split(arrayOfStacks[stack], "_");
                    
                    switch (stackNameAndStackHashArr[0]){
                        case "moveHistory":
                            ds_stack_clear(objRef.moveHistory); //clear deactivated position
                            ds_stack_read(objRef.moveHistory, stackNameAndStackHashArr[1]);
                            var string_objPos = ds_stack_pop(objRef.moveHistory);  
                            var array_objArr = scr_split(string_objPos, ",");
                            objRef.x = array_objArr[0]; 
                            objRef.y = array_objArr[1]; 
                            break;
                        case "movedDirHistory":
                            ds_stack_clear(objRef.movedDirHistory);
                            ds_stack_read(objRef.movedDirHistory, stackNameAndStackHashArr[1]);
                            objRef.movedDir = ds_stack_pop(objRef.moveHistory);  
                            break;
                        case "stateHistory": //TODO - some objects have unique states, how to tell difference ?
                            ds_stack_clear(objRef.stateHistory);
                            ds_stack_read(objRef.stateHistory, stackNameAndStackHashArr[1]);
                        break;
                    }
                }             
            }
        }
    }
    
    
    curLine = file_text_readln(saveFile); //read at the end of the loop
    //print(curLine);
}
file_text_close(saveFile);
