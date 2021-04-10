/// @param id
function mus_is_paused( argument0 ){
	return (audio_is_paused(global.music[argument0]));
}