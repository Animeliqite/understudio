/// @description Write Flavor Text

var _obj = id;

// Check if the dialogue writer doesn't exist
if (!instance_exists(flavorWriter)) {
	// Create the flavor writer
	flavorWriter = instance_create_depth(0, 0, 0, obj_textwriter);
	with (flavorWriter) {
		text = _obj.flavorText;
		voice = _obj.flavorVoice;
		textSpeed = 0;
		drawText = false;
	}
}
else {
	instance_destroy(flavorWriter);
	event_user(0);
}