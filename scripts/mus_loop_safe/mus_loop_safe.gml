/// @description  mus_loop_safe(sound, volume, pitch);
/// @param id
/// @param sound
/// @param volume
/// @param pitch
function mus_loop_safe(argument0, argument1, argument2, argument3) {
	if (!mus_is_playing(argument0)) {
	    mus_loop(argument0, argument1, argument2, argument3);
	}
	else if (mus_is_paused(argument0)) {
	    mus_resume(argument0);
	}
}
