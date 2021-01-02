function cutscene_stop_audio( soundid ){
	audio_stop_sound(soundid);
	cutscene_end_action();
}