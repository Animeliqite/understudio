/// @param audio
/// @param volume
/// @arg time
function sfx_set_volume(){
	var audio = argument[0]
	var volume = argument[1]
	var time = 0;
	
	if (!is_undefined(argument[2]))
		time = argument[2];
	
	audio_sound_gain(audio, volume, time);
}