/// @description draw_sprite_shadow(direction, distance, scale, colour, alpha);
/// @param direction
/// @param  distance
/// @param  scale
/// @param  colour
/// @param  alpha
///Draws the shadow of a sprite
///Using the calling object's x, y, image_angle, sprite_index & image_index
function draw_sprite_shadow(argument0, argument1, argument2, argument3, argument4) {
	/*
	 * Example use:
	 * draw_sprite_shadow(270, 3, 1, c_black, 0.5);
	 * draw_self();
	 */
	var dir = argument0;
	var len = argument1;
	var sca = argument2;
	var col = argument3;
	var alp = argument4;
	var xx = x+lengthdir_x(len, dir);
	var yy = y+lengthdir_y(len, dir);
	d3d_set_fog(true, col, 0, 1);
	draw_sprite_ext(sprite_index, image_index, xx, yy, sca, sca, image_angle, c_white, alp);
	d3d_set_fog(0, 0, 0, 0);




}
