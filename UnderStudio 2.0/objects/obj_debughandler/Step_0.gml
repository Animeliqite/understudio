/// @description Functionality

// Check if the game is in debug mode
if (DEBUG) {
	// Show performance info if the key is pressed
	show_debug_overlay(performanceInfo);
	if (keyboard_check_pressed(performanceKey))
		performanceInfo = !performanceInfo;
	
	// Show the room goto dialog if the key is pressed
	if (keyboard_check_pressed(roomGoToKey)) {
		prevGameSpeed = game_get_speed(gamespeed_fps); // Set the previous game speed
		game_set_speed(0, gamespeed_fps); // Pause the game
		roomGoToDialog = get_integer_async("Which room do you want to go to?", rm_empty);
	}
}
else {
	instance_destroy();
}