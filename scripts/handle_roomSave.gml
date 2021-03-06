///handle_roomSave(bool curRoom, obj_layer layer)

var saveCurRoom = argument0;
var layer = argument1;

print("-> handle_roomSave(" + string(saveCurRoom) + ", obj_layer layer)");

var xPos = 0;
var yPos = 0;

var activeRoomObjectsArr = undefined;
var tileSeparator = "";

/*
    This shit saves the room's current object positions along with all of the dynamic 
    memory used by it into a file so that it can be returned to normal when a player comes
    back.  This is so the room isn't reinitialized.  
    
    Save file default path is C:\Users\UserName\AppData\Local\beam
    
    *** TODO NOTE ***
        This will need to be hashed to prevent notepad SMEs!!!!.
    *** END TODO NOTE ***
    
    
    FILE FORMAT
    
    *****
    ---
    var fileName
    ---
    objAtTile(0,0):moveHistory_<stackHash>...;obj2AtTile(0,0):moveHis....;|obj2AtTile(0,1):...;|
    objAtTile(1,0)[localVar=value/localVar2=number]:moveHistory_<stackHash>;|
    ---
    *****
*/

// set save file for this room
var roomName = room_get_name(room);
var roomSaveFileName = roomName + ".sav"; // TODO -> should have a bkp file in case of failure to save/load
if (file_exists(roomSaveFileName)) file_delete(roomSaveFileName);

// write file header
var roomSaveFile = file_text_open_write(roomSaveFileName);
file_text_write_string(roomSaveFile, "*****"); //starts file fresh with write instead of append
file_text_writeln(roomSaveFile);
file_text_write_string(roomSaveFile, "---");
file_text_writeln(roomSaveFile);
file_text_write_string(roomSaveFile, roomName);
file_text_writeln(roomSaveFile);
file_text_write_string(roomSaveFile, "---");
file_text_writeln(roomSaveFile);


if (saveCurRoom){ //save from current room (not via layer)
    activeRoomObjectsArr = get_curRoomObjects(); //grabs objs from the room Rob is in
}

else{ //write to file using layer's map
    activeRoomObjectsArr = layer.roomMapArr;
}
    
    print("handle_roomSave: room map height: " + string(array_height_2d(activeRoomObjectsArr)));
    print("handle_roomSave: room map length: " + string(array_length_2d(activeRoomObjectsArr, yPos)));
    
    for (yPos = 0; yPos < array_height_2d(activeRoomObjectsArr); yPos++){
        for (xPos = 0; xPos < array_length_2d(activeRoomObjectsArr, yPos); xPos++){
            //print("handle_roomSave: WRITING at " + string(xPos) + "," + string(yPos) + ": " + string(activeRoomObjectsArr[yPos, xPos]));
            file_text_write_string(roomSaveFile, activeRoomObjectsArr[yPos, xPos]);
        }
        file_text_writeln(roomSaveFile);
    }

file_text_write_string(roomSaveFile, "---");

file_text_writeln(roomSaveFile);

// close file
file_text_close(roomSaveFile);
