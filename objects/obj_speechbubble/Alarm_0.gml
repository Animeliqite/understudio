if (!instance_exists(obj_writer)) {
	create_writer(x + 35, y - (sprite_get_height(sprite[0])) + 70, text, format, fnt_speech, c_black, 2, sound, textSpeed);
	ready = true;
}