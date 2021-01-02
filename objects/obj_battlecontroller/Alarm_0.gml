/// @description Battle End
if (!instance_exists(obj_persistent_fade)) { 
    var fade = instance_create(0, 0, obj_persistent_fade);
    fade.targetRoom = global.currentroom;
}

audio_sound_gain(global.currentsong, 0, 500);

global.cutscene = true;

