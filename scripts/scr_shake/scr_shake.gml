/// @description  scr_shake(target, shake_x, shake_y);
/// @param target
/// @param  shake_x
/// @param  shake_y
function scr_shake(argument0, argument1, argument2) {

	var target = argument0;
	var shake_x = argument1;
	var shake_y = argument2;

	var instance = instance_create(0, 0, obj_shaker);

	instance.target = target;
	instance.shake_x = shake_x;
	instance.shake_y = shake_y;



}
