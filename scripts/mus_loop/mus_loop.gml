/// @description  mus_loop(sound, volume, pitch);
/// @param id
/// @param sound
/// @param volume
/// @param pitch
function mus_loop(argument0, argument1, argument2, argument3) {
	global.music[argument0] = audio_create_stream("data/mus/" + argument1 + ".ogg");
	global.musicExt[argument0] = audio_play_sound(global.music[argument0], 10, true);
	audio_sound_gain(global.music[argument0], argument2, 0);
	audio_sound_pitch(global.music[argument0], argument3);
}
