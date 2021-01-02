global.spawn = 2;

if (!instance_exists(obj_persistent_fade)) { 
    var fade = instance_create(0, 0, obj_persistent_fade);
    fade.targetRoom = room_previous(room);
}

global.cutscene = true;

