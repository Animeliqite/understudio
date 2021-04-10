/// @description mus_stop(sid);
/// @param id
function mus_stop(argument0) {
	audio_destroy_stream(global.music[argument0]);
	//global.music[argument0] = "";
}
