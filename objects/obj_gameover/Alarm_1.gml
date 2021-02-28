repeat (6) {
	instance_create(x, y, obj_heart_shard);
}

audio_play_sound(snd_soulshatter, 10, false);

alarm[2] = 60;