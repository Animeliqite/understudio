/// @description  mus_set_pitch(sound, pitch);
/// @param id
/// @param pitch
function mus_set_pitch(argument0, argument1) {
	audio_sound_pitch(global.music[argument0], argument1);
}
