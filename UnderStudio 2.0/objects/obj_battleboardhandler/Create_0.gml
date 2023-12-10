/// @description Initialize

_x			= 320;
_y			= 320;
width		= 283;
height		= 65;
alpha		= 1;

blendBorder	= c_white;
blendBG		= c_black;

updatePosition = function(__x, __y, w, h) {
	var _inst = obj_battleboardhandler;
	execute_tween(_inst, "_x", __x, "linear", abs(__x - _x) / room_speed, false);
	execute_tween(_inst, "_y", __y, "linear", abs(__y - _y) / room_speed, false);
	execute_tween(_inst, "width", w, "linear", abs(__x - _x) / room_speed, false);
	execute_tween(_inst, "height", h, "linear", abs(__y - _y) / room_speed, false);
}