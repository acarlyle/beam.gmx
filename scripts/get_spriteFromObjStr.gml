///get_spriteFromObjStr(var objStr)

var objStr = argument0;

//print(" -> get_spriteFromObjStr: orig-strlen of " + string(objStr) + " is " + string(strlen(objStr)));

//print(" -> get_spriteFromObjStr: strlen of " + string(objStr) + " is " + string(strlen(objStr)));

//print(" -> get_spriteFromObjStr(" + string(objStr) + ")");

//var objStrSplitBy_ = scr_split(objStr, "_");
//var spriteStr = "spr_" + string(objStrSplitBy_[1]);
//print(spriteStr);
//print(asset_get_index(spriteStr));
//return asset_get_index(spriteStr);

return object_get_sprite(get_objectFromString(objStr));
