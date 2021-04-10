/// @description Battle End
if (!instance_exists(obj_persistent_fade)) { 
    var fade = instance_create(0, 0, obj_persistent_fade);
    fade.targetRoom = global.currentroom;
}

mus_set_volume(4, 0, 1000);

global.cutscene = true;

