/// @description Initialize

// Check if the game is in debug mode
if (DEBUG) {
	// Performance UI
	performanceInfo	= false;
	performanceKey	= vk_f1;
	
	// Used to test different rooms
	roomGoToDialog	= -1;
	roomGoToKey		= vk_f2;
	
	// Other
	prevGameSpeed	= game_get_speed(gamespeed_fps);
}
else {
	var notice = "This code is used for debug mode controls, but it's empty for you."
}