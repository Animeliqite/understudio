/// @description  scr_shop_draw_talktitle(lineNo, highlight, string);
/// @param lineNo
/// @param  highlight
/// @param  string
function scr_shop_draw_talktitle(argument0, argument1, argument2) {

	var line = argument0;
	var highlight = argument1;
	var text = argument2;

	var textX = 30;

	var textScale = 1;
	var textMaxScale = 170;

	if (highlight == true) {
	    draw_set_color(c_yellow);
	    text = "(NEW) " + argument2;
	}
	else {
	    draw_set_color(c_white);
    
	    text = argument2;
	}

	if (string_width(string_hash_to_newline(text)) > textMaxScale)
	    textScale = textMaxScale / string_width(string_hash_to_newline(text));

	draw_text_transformed(textX, 130 + 20 * line, string_hash_to_newline(text), textScale, 1, 0);

	draw_set_color(c_white);



}
