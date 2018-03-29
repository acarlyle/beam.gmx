///handle_gameMove(par_robot robot);

var robot = argument0;

print("");
print("HANDLE GAME MOVE");

//for (var i = 0; i < array_length_1d(global.roomContents); i++){
//    var object = global.roomContents[i];
//    print(object_get_name(object.object_index));
//}

handle_cleanUpElementEffects();

for (var i = 0; i < array_length_1d(global.roomContents); i++){
    var object = global.roomContents[i];
    with(object){
        
        print("Handling " + object_get_name(object.object_index));
        
        //Handles: par_cannon
        if (parentOf(object) == "par_cannon"){
            print("handling cannon move");
            move_cannon(object, robot);
        }
        
        /*
            HANDLE DIFFERENT TYPES OF OBJECT MOVEMENTS
        */ 
        
        //If object is on top of a snare, don't do anything with it
        if (instance_place(x, y, par_snare)) {
            continue;
        }
        //Handles: obj_trigger, obj_triggerDoor
        else if (triggerDoorPtr != undefined){
            move_trigger(object, robot);
        }
        //Handles: obj_eviscerator
        else if (isEviscerator){
            move_eviscerator(object, robot);
        }
        //Handles: par_arrow
        else if (isArrow){
            move_arrow(object);
        }
        //Handles: par_fallingPlatform
        else if (isFallingPlatform){
            move_fallingPlatform(object, robot);
        }
        //Handles: obj_spike
        else if (object.isSpike){
            move_spike(object, robot);
        }
        //Handles: par_block, obj_key, obj_magneticSnare
        else if ((canPull || canPush)){
            move_pullPushables(object, robot);
        }
        else if (object_get_name(object.object_index) == "obj_blackHole"){
            move_blackHole(object);
        }
    }
}

handle_prioritizeItems();

moved = false;
