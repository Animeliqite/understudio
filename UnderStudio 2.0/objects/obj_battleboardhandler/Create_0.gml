/// @description Initialize

_x			= 320;
_y			= 320;
width		= 283;
height		= 65;
alpha		= 1;
spd			= 10;

blendBorder	= c_white;
blendBG		= c_black;

updatePosition = function(__x, __y, w, h) {
	var _inst = obj_battleboardhandler;
	execute_tween(_inst, "_x", __x, "linear", round(abs((__x - _x) / spd)), false);
	execute_tween(_inst, "_y", __y, "linear", round(abs((__y - _y) / spd)), false);
	execute_tween(_inst, "width", w, "linear", round(abs((w - width) / spd)), false);
	execute_tween(_inst, "height", h, "linear", round(abs((h - height) / spd)), false);
}