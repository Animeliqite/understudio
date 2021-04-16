image_index = (global.murderlv > 0 ? 1 : 0);
image_speed = 0;
depth = depth_overworld.ui;

audio_play_sound(snd_enc0, 10, false);
alarm[0] = room_speed / 1.5;