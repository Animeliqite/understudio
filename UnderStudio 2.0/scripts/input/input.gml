function input_init() {
	global.inputConfirm = undefined;
	global.inputConfirmPress = undefined;
	global.inputConfirmRelease = undefined;
	
	global.inputCancel = undefined;
	global.inputCancelPress = undefined;
	global.inputCancelRelease = undefined;
	
	global.inputMenu = undefined;
	global.inputMenuPress = undefined;
	global.inputMenuRelease = undefined;
}

function input_update() {
	global.inputKeys[0] = ord("Z");
	global.inputKeys[1] = ord("X");
	global.inputKeys[2] = ord("C");
	
	keyboard_set_map(vk_enter, global.inputKeys[0]);
	keyboard_set_map(vk_shift, global.inputKeys[1]);
	keyboard_set_map(vk_control, global.inputKeys[2]);
	
	global.inputConfirm = keyboard_check(global.inputKeys[0]);
	global.inputConfirmPress = keyboard_check_pressed(global.inputKeys[0]);
	global.inputConfirmRelease = keyboard_check_released(global.inputKeys[0]);
	
	global.inputCancel = keyboard_check(global.inputKeys[1]);
	global.inputCancelPress = keyboard_check_pressed(global.inputKeys[1]);
	global.inputCancelRelease = keyboard_check_released(global.inputKeys[1]);
	
	global.inputMenu = keyboard_check(global.inputKeys[2]);
	global.inputMenuPress = keyboard_check_pressed(global.inputKeys[2]);
	global.inputMenuRelease = keyboard_check_released(global.inputKeys[2]);
}