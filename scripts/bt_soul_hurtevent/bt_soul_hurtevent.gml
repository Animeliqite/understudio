function bt_soul_hurtevent(){
	if (obj_battleheart.inv == 30) {
		shake_screen(10);
		audio_play_sound(snd_soulhurt, 10, false);
		obj_battleheart.hurt = true;
		obj_battleheart.inv = 30;
		instance_destroy();
	}
}