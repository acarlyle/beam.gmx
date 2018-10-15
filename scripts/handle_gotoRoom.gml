///handle_gotoRoom(room rmName, var state)

var rm = argument0;
var state = argument1; // { gotoRoom, undoRoom }

print("handle_gotoRoom(" + string(room_get_name(rm)) + ", " + string(state) + ");");

var saveFileName = string(rm) + ".sav";

//if state == "gotoRoom" { with (par_robot) push_robotState(self, true, 0, 0); } //0, 0 because we're only pushing the current pos
if (state == "undoRoom" || state == "gotoRoom"){    
    //with (par_robot) {
        //handle_pushOntoStack(self, true); //push final state of room, cur obj positions
        //handle_pushOntoStack(self, true); //push final state of room, cur obj positions
    //}
}
room_goto(rm);

print("");
print("-------------------------------------");
print("----------ROOM TRANSITION------------");
//handle_roomSave(false, layer); //TODO
    
print("-------------------------------------");
print("");

//handle_freeMemory(); NOT HERE

return true; //successful gotoRoom
