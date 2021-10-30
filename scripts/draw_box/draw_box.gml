/// @description draw_box(x1, y1, x2, y2);
/// @param x1
/// @param y1
/// @param x2
/// @param y2
function draw_box() {
	var x1 = argument0;
	var y1 = argument1;
	var x2 = argument2;
	var y2 = argument3;
	
	var width = 5;
	
	draw_set_color(c_white);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_color(c_black);
	draw_rectangle(x1 + width, y1 + width, x2 - width, y2 - width, false);
	draw_set_color(c_white);
}