/// @description  mus_set_volume(sound, volume);
/// @param id
/// @param volume
/// @param time
function mus_set_volume(argument0, argument1, argument2) {
	audio_sound_gain(global.musicExt[argument0], argument1, argument2);
}
