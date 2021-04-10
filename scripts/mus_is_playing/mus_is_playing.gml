/// @description  mus_is_playing(audio);
/// @param id
function mus_is_playing(argument0) {
	return (!is_string(global.music[argument0]) && (audio_is_playing(global.music[argument0])));
}
