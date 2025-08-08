/// @description Initialize

audioStream = -1;
currentPitch = audio_sound_get_pitch(audioStream);
targetPitch = 1;

tween = "linear";
duration = 30;
relative = false;
alarm[0] = 1;