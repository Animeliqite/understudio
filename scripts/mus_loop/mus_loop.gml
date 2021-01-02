/// @description  mus_loop(sound, volume, pitch);
/// @param sound
/// @param  volume
/// @param  pitch
function mus_loop(argument0, argument1, argument2) {

	audio_play_sound(argument0, 10, true);
	audio_sound_gain(argument0, argument1, 0);
	audio_sound_pitch(argument0, argument2);



}
