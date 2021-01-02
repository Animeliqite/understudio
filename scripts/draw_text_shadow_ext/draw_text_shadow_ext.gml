/// @description draw_text_shadow_ext(x, y, string, colour, shadow_colour, shadow_direction, shadow_distance, shadow_alpha)
/// @param x
/// @param  y
/// @param  string
/// @param  colour
/// @param  shadow_colour
/// @param  shadow_direction
/// @param  shadow_distance
/// @param  shadow_alpha
function draw_text_shadow_ext(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {
	var xx = argument0;
	var yy = argument1;
	var str = argument2;
	var dir = argument5;
	var len = argument6;

	//Draw text shadow
	draw_set_colour(argument4);
	draw_set_alpha(argument7);
	var shadow_x = xx+lengthdir_x(len, dir);
	var shadow_y = yy+lengthdir_y(len, dir);
	draw_text(shadow_x, shadow_y, string_hash_to_newline(str));

	//Draw text
	draw_set_colour(argument3);
	draw_set_alpha(1);
	draw_text(xx, yy, string_hash_to_newline(str));
	draw_set_colour(c_white);



}
