/// @description Functionality

// Proceeding to the next room
if (bt_enter_p) {
	// Check if the title text is visible
	if (showTitle) {
		audio_stop_all();
		room_goto_next();
	}
}