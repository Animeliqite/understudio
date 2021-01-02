/// @description draw_text_shadow(x, y, string, colour, shadow_colour, shadow_alpha)
/// @param x
/// @param  y
/// @param  string
/// @param  colour
/// @param  shadow_colour
/// @param  shadow_alpha
function draw_text_shadow(argument0, argument1, argument2, argument3, argument4, argument5) {
	var xx = argument0;
	var yy = argument1;
	var str = argument2;

	//Draw shadow
	draw_set_colour(argument4);
	draw_set_alpha(argument5);
	draw_text(xx, yy+1, string_hash_to_newline(str));

	//Draw Text
	draw_set_colour(argument3);
	draw_set_alpha(1);
	draw_text(xx, yy, string_hash_to_newline(str));
	draw_set_colour(c_white);



}
