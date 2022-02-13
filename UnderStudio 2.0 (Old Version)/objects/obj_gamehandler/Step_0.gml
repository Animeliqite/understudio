/// @description Functionality

// Execute necessary scripts
input_update();

// Fullscreen
if (keyboard_check_pressed(vk_f4))
	window_set_fullscreen(!window_get_fullscreen());