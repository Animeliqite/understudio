/// @description Draw Additional UI

var _board = obj_battleboardhandler;
var _x = _board._x - _board.width + 20,
	_y = _board._y - _board.height + 20;

if (instance_exists(flavorWriter))
	draw_rpgtext(_x + (flavorFace != undefined ? 118 : 0), _y, "`effect 3`" + flavorWriter.written, flavorFont, 1, global.mainFontWidth, global.mainFontHeight, 1, 1, c_white);

if (flavorActionText != "") {
	draw_rpgtext(_x, _y, "`effect 3`" + flavorActionText, fnt_main, 1,  global.mainFontWidth, global.mainFontHeight, 1, 1, c_white);
}