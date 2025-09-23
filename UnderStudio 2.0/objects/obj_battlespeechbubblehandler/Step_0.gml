if (state == 0) {
	writer = instance_create_depth(0, 0, 0, obj_textwriter);
	writer.drawText = false;
	writer.set_text(writer_text);
	writer.voice = writer_voice;
	writer.skippable = writer_skippable;
	
	state = 1;
}
else {
	if (writer.completed) {
		if (BT_ENTER_P) {
			instance_destroy();
		}
	}
	else {
		if (BT_SHIFT_P && writer_skippable) {
			writer.skipText = true;
		}
	}
}