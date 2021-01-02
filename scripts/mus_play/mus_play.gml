/// @description  mus_play(sound, volume, pitch);
/// @param sound
/// @param  volume
/// @param  pitch
function mus_play(argument0, argument1, argument2) {

	audio_play_sound(argument0, 10, false);
	audio_sound_gain(argument0, argument1, 0);
	audio_sound_pitch(argument0, argument2);



}
