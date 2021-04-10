/// @description  mus_pause(sound);
/// @param id
function mus_pause(argument0) {
	if (global.music[argument0] != "") {
	    audio_pause_sound(global.music[argument0]);
	}
}