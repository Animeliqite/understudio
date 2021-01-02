left = keyboard_check(vk_left);
right = keyboard_check(vk_right);
up = keyboard_check(vk_up);
down = keyboard_check(vk_down);

left_p = keyboard_check_pressed(vk_left);
right_p = keyboard_check_pressed(vk_right);
up_p = keyboard_check_pressed(vk_up);
down_p = keyboard_check_pressed(vk_down);

confirm = keyboard_check_pressed(vk_enter) || (keyboard_check_pressed(ord("Z"))) || (gamepad_button_check_pressed(0, gp_face1));
cancel = keyboard_check_pressed(vk_lshift) || (keyboard_check_pressed(ord("X"))) || (gamepad_button_check_pressed(0, gp_face2));
menu = keyboard_check_pressed(vk_lcontrol) || (keyboard_check_pressed(ord("C"))) || (gamepad_button_check_pressed(0, gp_face4));

cancel_h = keyboard_check(vk_lshift) || (keyboard_check(ord("X"))) || (gamepad_button_check(0, gp_face2));

