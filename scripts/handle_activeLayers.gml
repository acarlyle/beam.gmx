///handle_activeLayers(ds_list activeLayers)

var activeLayers = argument0;

scr_clearStepGlobals();

var inputString = get_input();

switch(inputString)
{
    case "move":
        break;
    case "restart":
        global.restartRoom = true;
        //global.playerCanMove = false;
        break;
}   

//handle move, restart room
if (inputString != false)
{
    //handle each active layer
    for (var l = 0; l < ds_list_size(activeLayers); l++)
    {
    
        var layer = activeLayers[| l];
        
        print("");
        print(" ####################################### ");
        print("");
        print("handle_activeLayers: handling layer for room " + string(layer.roomName));
        
        if (global.restartRoom)
        {
            handle_restartRoom(layer);
            continue;
        }
    
        /*
            TODO -> Check if the player can move before you handle every object.  The rules of dotpull work in the way
            that in order for objects to move, you have to move first.  
        */
        
        if (global.playerCanMove)
        {
        
            /*
                If there are objects in this layer, handle it normally (robot moves, object moves, repeat).
                Otherwise, if a layer is active, handle the objects in that layer, even if there's no robots
                there (this allows for active objects such as spikes to continue moving on a floor below the 
                player).  
            */
            
            //print(" -> handle_activeLayers list_robots size: " + string(ds_list_size(layer.list_robots)));
            
            if (ds_list_size(layer.list_robots) > 0)
            {
                for (var r = 0; r < ds_list_size(layer.list_robots); r++) //foreach robot in this layer
                {
                    layer.robot = layer.list_robots[| r]; //robot enum
                    
                    if (global.restartRoom) break;
                    
                    if (!layer.robot[| ROBOT.ISDEAD])
                    {
                        print("handle_activeLayers: robot " + string(layer.robot[| OBJECT.NAME]));
                        if (global.playerMoved || layer.robot[| OBJECT.NAME] == "obj_player")
                        {
                            handle_layerRobots(layer); //move is true if movement key is pressed
                        }
                    }
                    
                    if (layer.robot)
                    {
                        if (layer.robot[| OBJECT.MOVED]) 
                        {
                            print("player moved totes");
                            handle_layerObjects(layer);  //moved is true if player successfully moved
                            layer.robot[| OBJECT.MOVED] = false;
                        }
                    }
                    
                    //TODO -> Correctly update the Layer if an object has moved (current stuff is hardcoded)
                    
                    //var stoopidTrigger = instance_place(16, 112, obj_trigger);
                    //if (stoopidTrigger) print("STOOOOPID STOOPID!!!");
                    
                    //save state
                    if (global.playerMoved)
                    {
                        handle_gameSave(obj_player);
                        handle_updateSurface(layer.surfaceInf);
                    }
                    //cleanup memory before switch rooms.  need to remove robot stuff from this layer
                    if (obj_layerManager.switchMainLayer)
                    {
                        //Add Robot to new Player Layer if the layer exists
                        if (layer_isActive(obj_layerManager.playerLayer))
                        {
                            handle_addRobotToLayer(layer.robot, obj_layerManager.playerLayer);
                        }
                        //Remove Robot from current layer
                        handle_switchPlayerLayer(layer, layer.robot);
                        
                        obj_layerManager.loadedRoom = false;
                        obj_layerManager.loadingRoom = true;
                        
                        layer.surfaceInf.isMainSurface = false;
                        layer.surfaceInf.alpha /= 2;
                        
                    }
                }
            }
            else if (layer.isActive) //No robot present, but layer has active objects to move
            {
                handle_layerObjects(layer); 
                handle_updateSurface(layer.surfaceInf);  
            }
        }
    }
    
    if (global.playerMoved || obj_layerManager.switchMainLayer)
    {
        obj_layerManager.turnNum++; //increment turn counter
    }
    
    print("");
    print("----------------------------------------------");
    print(" -> handle_activeLayers: END of LayerManager Turn " + string(obj_layerManager.turnNum));
    print("");
    
}
