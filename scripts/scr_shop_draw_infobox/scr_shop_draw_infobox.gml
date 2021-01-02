/// @description  scr_shop_draw_infobox(yTop, text);
/// @param yTop
/// @param  text
function scr_shop_draw_infobox(argument0, argument1) {
	var yTop = argument0;
	var text = argument1;
	var dividerX = 210;
	var textX = dividerX + 14;
	var textY = yTop + 14;

	draw_set_color(c_white);
	draw_rectangle(dividerX, 120, 320, yTop, false);

	if (yTop < 116) {
	    draw_set_color(c_black);
	    draw_rectangle(dividerX + 4, 120, 316, yTop + 4, false);
	    draw_set_color(c_white);
	}

	draw_text(textX, textY, string_hash_to_newline(text));



}
