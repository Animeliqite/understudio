/// @description Functionality

if (keyboard_check_pressed(ord("Z"))) {
	if (showTitle) {
		audio_stop_all();
		room_goto_next();
	}
}