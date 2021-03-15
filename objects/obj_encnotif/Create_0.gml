if (global.murderlv > 0)
    image_index = 1;
else
    image_index = 0;

image_speed = 0;

x = obj_player.x;
y = obj_player.y - 20;

audio_play_sound(snd_enc0, 10, false);

alarm[0] = room_speed / 1.5;

global.cutscene = true;

