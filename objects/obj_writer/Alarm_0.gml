var char_at = string_char_at(text[text_no], character_no);
if (character_no < string_length(text[text_no])) {
	character_no++;
	
	alarm[0] = text_speed;
	
	if (char_at != " ") {
		for (var i = 0; i < array_length_1d(sound_array); i++;)
			audio_stop_sound(sound_array[i]);
		
		audio_play_sound(sound_array[random_range(0, array_length_1d(sound_array))], 10, false);
	}
}