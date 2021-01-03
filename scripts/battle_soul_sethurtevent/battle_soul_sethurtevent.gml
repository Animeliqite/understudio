function battle_soul_sethurtevent(){
	if (obj_battleheart.inv == 30) {
		shake_screen(5);
		audio_play_sound(snd_soulhurt, 10, false);
		obj_battleheart.hurt = true;
		obj_battleheart.inv = 30;
		instance_destroy();
	}
}