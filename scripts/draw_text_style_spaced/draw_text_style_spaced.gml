/// @param text
/// @param x
/// @param y
/// @param font
/// @param color
/// @args halign
/// @args valign
/// @args xscale
/// @args yscale
/// @args spacex
/// @args spacey
/// @args angle

function draw_text_style_spaced( argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11 ){
	var _x = argument1;
	var _y = argument2;
	
	var _space_x = argument9;
	var _space_y = argument10;
	
	draw_set_halign(argument5);
	draw_set_valign(argument6);
	
	draw_set_color(argument4);
	draw_set_font(argument3);
	
	for (var i = 0; i < string_length(argument0); i++) {
		var c = string_char_at(argument1, i);
		
		if (c == "#") {
			_y += string_height(c) + _space_y;
		}
		else {
			draw_text_transformed(_x, _y, string_copy(argument0, c, 1), argument7, argument8, argument11);
			_x += string_width(c) + _space_x;
		}
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}