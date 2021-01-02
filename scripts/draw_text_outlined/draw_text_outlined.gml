/// @description draw_text_outlined(x, y, string, colour, alpha, outline_colour, outline_alpha)
/// @param x
/// @param  y
/// @param  string
/// @param  colour
/// @param  alpha
/// @param  outline_colour
/// @param  outline_alpha
function draw_text_outlined(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	var xx = argument0;
	var yy = argument1;
	var str = argument2;
	draw_set_colour(argument5);
	draw_set_alpha(argument6);
	draw_text(xx-1, yy, string_hash_to_newline(str));
	draw_text(xx+1, yy, string_hash_to_newline(str));
	draw_text(xx, yy-1, string_hash_to_newline(str));
	draw_text(xx, yy+1, string_hash_to_newline(str));
	draw_set_colour(argument3);
	draw_set_alpha(argument4);
	draw_text(xx, yy, string_hash_to_newline(str));
	draw_set_colour(c_white);



}
