function cutscene_play_audio( soundid, loop ){
	audio_play_sound(soundid, 10, loop);
	cutscene_end_action();
}