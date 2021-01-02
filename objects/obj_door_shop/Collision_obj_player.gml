global.spawn = spawn;
global.shopNo = shopNo;

if (!instance_exists(obj_persistent_fade)) { 
    var fade = instance_create(0, 0, obj_persistent_fade);
    fade.targetRoom = room_shop;
}

global.cutscene = true;

