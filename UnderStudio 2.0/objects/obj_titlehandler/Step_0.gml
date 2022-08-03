/// @description Functionality

// Proceeding to the next room
if (BT_ENTER_P) {
	// Check if the title text is visible
	if (showTitle) {
		audio_stop_all();
		room_goto_next();
	}
}