/// @param text
/// @param x
/// @param y
/// @param font
/// @param color
/// @args halign
/// @args valign
/// @args xscale
/// @args yscale
/// @args angle

function draw_text_style_scaled( argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9 ){
	draw_set_halign(argument5);
	draw_set_valign(argument6);
	
	draw_set_color(argument4);
	draw_set_font(argument3);
	
	draw_text_transformed(argument1, argument2, argument0, argument7, argument8, argument9);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}