/// @description Draw Additional UI

var _board = obj_battleboardhandler;
var _x = _board._x - _board.width + 20,
	_y = _board._y - _board.height + 20;

if (instance_exists(flavorWriter)) {
	draw_text_extended(_x + (flavorFace != undefined ? 118 : 0), _y, flavorWriter.raw_text, {
		halign: fa_left,
		valign: fa_top,
		size: 1,
		visible: flavorWriter.visible_chars,
		font: flavorFont,
		alpha: 1,
		color: c_white,
		effect: "part_shaky",
		letter_width: global.mainFontWidth,
		letter_height: global.mainFontHeight,
		letter_spacing: 0,
		line_spacing: 1,
		line_break: -1
	});
}
else {
	if (flavorActionText != "") {
		draw_text_extended(_x, _y, flavorActionText, {
			halign: fa_left,
			valign: fa_top,
			size: 1,
			visible: 9999,
			font: flavorFont,
			alpha: 1,
			color: c_white,
			effect: "part_shaky",
			letter_width: global.mainFontWidth,
			letter_height: global.mainFontHeight,
			letter_spacing: 0,
			line_spacing: 1,
			line_break: -1
		});
	}
}