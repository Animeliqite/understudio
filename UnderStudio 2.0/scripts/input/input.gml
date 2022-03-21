function input_init() {
	global.inputKeys[0] = ord("Z");
	global.inputKeys[1] = ord("X");
	global.inputKeys[2] = ord("C");
	global.inputKeys[3] = [vk_left, vk_right, vk_up, vk_down];
	
	global.inputConfirm = undefined;
	global.inputConfirmPress = undefined;
	global.inputConfirmRelease = undefined;
	
	global.inputCancel = undefined;
	global.inputCancelPress = undefined;
	global.inputCancelRelease = undefined;
	
	global.inputMenu = undefined;
	global.inputMenuPress = undefined;
	global.inputMenuRelease = undefined;
	
	global.inputLeft = undefined;
	global.inputLeftPress = undefined;
	global.inputLeftRelease = undefined;
	
	global.inputRight = undefined;
	global.inputRightPress = undefined;
	global.inputRightRelease = undefined;
	
	global.inputUp = undefined;
	global.inputUpPress = undefined;
	global.inputUpRelease = undefined;
	
	global.inputDown = undefined;
	global.inputDownPress = undefined;
	global.inputDownRelease = undefined;
}

function input_update() {
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
	
	global.inputLeft = keyboard_check(global.inputKeys[3][0]);
	global.inputLeftPress = keyboard_check_pressed(global.inputKeys[3][0]);
	global.inputLeftRelease = keyboard_check_released(global.inputKeys[3][0]);
	
	global.inputRight = keyboard_check(global.inputKeys[3][1]);
	global.inputRightPress = keyboard_check_pressed(global.inputKeys[3][1]);
	global.inputRightRelease = keyboard_check_released(global.inputKeys[3][1]);
	
	global.inputUp = keyboard_check(global.inputKeys[3][2]);
	global.inputUpPress = keyboard_check_pressed(global.inputKeys[3][2]);
	global.inputUpRelease = keyboard_check_released(global.inputKeys[3][2]);
	
	global.inputDown = keyboard_check(global.inputKeys[3][3]);
	global.inputDownPress = keyboard_check_pressed(global.inputKeys[3][3]);
	global.inputDownRelease = keyboard_check_released(global.inputKeys[3][3]);
}