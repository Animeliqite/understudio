xx = x;
yy = y;
siner = (current_time / 250) * 5;
color = c_white;
font = fnt_dialogue;
alpha = 1;

for (var i = 1; i < character_no + 1; i++;) {
	var char_at = string_char_at(text[text_no], i);
	siner++;
	
	draw_set_alpha(alpha);
	draw_set_color(color);
	draw_set_font(font);
	
	switch (effect) {
		case text_effect.none:
			draw_text_transformed(xx, yy, string_copy(text[text_no], i, 1), x_scale, y_scale, angle);
			break;
		case text_effect.shake:
			draw_text_transformed(xx + random_range(-shake_max_x, shake_max_x), yy + random_range(-shake_max_y, shake_max_y), string_copy(text[text_no], i, 1), x_scale, y_scale, angle);
			break;
		case text_effect.partly_shake:
			draw_text_transformed(xx + choose(random_range(-shake_max_x, shake_max_x), 0), yy + choose(random_range(-shake_max_y, shake_max_y), 0), string_copy(text[text_no], i, 1), x_scale, y_scale, angle);
			break;
		case text_effect.wave:
			draw_text_transformed(xx + cos(siner / 2.5), yy + sin(siner / 2.5), string_copy(text[text_no], i, 1), x_scale, y_scale, angle);
			break;
	}
	
	if (char_at == "[") {
		var coming_char = "";
		do {
			coming_char += char_at
		}
		until (char_at + coming_char = "]");
		
		for (var n = 0; n < string_length(command); n++;) {
			if (char_at + n + 1 == string_char_at(command, n)) {
				if (char_at + string_length(command) + 1 == "]")
					event_user(0);
			}
		}
	}
	xx += string_width(string_copy(text[text_no], i, 1)) + char_width;
}

draw_set_alpha(1);
draw_set_color(c_white);