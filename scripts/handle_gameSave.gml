///handle_gameSave(par_robot robot)

// Save file default path is C:\Users\UserName\AppData\Local\beam

print("handle game save");
if (file_exists("save.sav")) file_delete("save.sav");
var saveFile = file_text_open_write("save.sav");
var saveRoom = room;
file_text_write_real(saveFile, saveRoom);

file_text_close(saveFile); 

handle_roomSave();

print("Game saved!");
