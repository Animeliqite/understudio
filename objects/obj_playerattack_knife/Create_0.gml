currentMonster = obj_battlemanager.monsters[bt_getcurrent_monster()];
image_speed = 0.25;
image_xscale = 1.5;
image_yscale = 1.5;

obj_battlemanager.stateSelection = 2;
audio_play_sound(snd_strike, 10, false);