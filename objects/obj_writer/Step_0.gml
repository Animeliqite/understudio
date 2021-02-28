var text_end = array_length_1d(text) - 1;

if (character_no >= string_length(text[text_no])) {
	if (global.confirm) {
		if (text_no < text_end) {
			text_no++;
			character_no = 0;
			alarm[0] = text_speed;
		}
		else
			instance_destroy();
	}
}
else {
	if (global.cancel) {
		character_no = string_length(text[text_no]);
	}
}