/// @description  mus_loop_safe(sound, volume, pitch);
/// @param sound
/// @param  volume
/// @param  pitch
function mus_loop_safe(argument0, argument1, argument2) {

	if (!mus_is_playing(argument0)) {
	    audio_stop_all();
	    mus_loop(argument0, argument1, argument2);
	}
	else if (audio_is_paused(argument0)) {
	    mus_resume(argument0);
	}



}
