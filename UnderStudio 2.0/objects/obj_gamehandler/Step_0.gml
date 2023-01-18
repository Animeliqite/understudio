/// @description Functionality

// Execute necessary scripts
input_update();

// Diannex waiting timer
if (dxWaitTimer > 0) {
	if (alarm[1] < 0)
		alarm[1] = 1;
}

// Fullscreen
if (keyboard_check_pressed(vk_f4))
	window_set_fullscreen(!window_get_fullscreen());