global.left_hold = keyboard_check(vk_left);
global.right_hold = keyboard_check(vk_right);
global.up_hold = keyboard_check(vk_up);
global.down_hold = keyboard_check(vk_down);

global.left_press = keyboard_check_pressed(vk_left);
global.right_press = keyboard_check_pressed(vk_right);
global.up_press = keyboard_check_pressed(vk_up);
global.down_press = keyboard_check_pressed(vk_down);

global.confirm = keyboard_check_pressed(vk_enter) || (keyboard_check_pressed(ord("Z"))) || (gamepad_button_check_pressed(0, gp_face1));
global.cancel = keyboard_check_pressed(vk_lshift) || (keyboard_check_pressed(ord("X"))) || (gamepad_button_check_pressed(0, gp_face2));
global.menu = keyboard_check_pressed(vk_lcontrol) || (keyboard_check_pressed(ord("C"))) || (gamepad_button_check_pressed(0, gp_face4));

global.cancel_hold = keyboard_check(vk_lshift) || (keyboard_check(ord("X"))) || (gamepad_button_check(0, gp_face2));