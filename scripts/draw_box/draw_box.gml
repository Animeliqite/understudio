/// @description  draw_box(x1, y1, x2, y2);
/// @param x1
/// @param  y1
/// @param  x2
/// @param  y2
function draw_box(argument0, argument1, argument2, argument3) {

	var x1 = argument0;
	var y1 = argument1;
	var x2 = argument2;
	var y2 = argument3;

	if (room != room_battle) {
	    draw_set_color(c_white);
	    draw_rectangle(x1, y1, x2, y2, false);
	    draw_set_color(c_black);
	    draw_rectangle(x1 + 3, y1 + 3, x2 - 3, y2 - 3, false);
	}
	else {
	    draw_set_color(c_white);
	    draw_rectangle(x1, y1, x2, y2, false);
	    draw_set_color(c_black);
	    draw_rectangle(x1 + 5, y1 + 5, x2 - 5, y2 - 5, false);
	}
	draw_set_color(c_white);



}
