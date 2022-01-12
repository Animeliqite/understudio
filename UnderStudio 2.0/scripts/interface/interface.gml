function RPGText(_x, _y, text, scaleX = 1, scaleY = 1, charWidth = string_width("A") * 1.1, charHeight = string_height("A") * 1.1) constructor {
	var color = c_white;
	var font = fnt_main;
	var effect = 0;
	var siner = 0;
	
	var cx = _x, cy = _y;
	for (var i = 1; i < string_length(text) + 1; ++i) {
		var c = string_char_at(text, i);
		
		switch (c) {
			case "=":
				i++;
				var cNext = string_char_at(text, i);
				switch (cNext) {
					case "c":
						i++;
						var colorCheck = string_char_at(text, i);
						switch (colorCheck) {
							case "W": color = c_white; break;
							case "X": color = c_black; break;
							case "B": color = c_blue; break;
							case "Y": color = c_yellow; break;
							case "R": color = c_red; break;
						}
						break;
					case "e":
						i++;
						effect = string_char_at(text, i);
						break;
				}
				break;
			case "#":
				cx = _x;
				cy += charHeight;
				break;
			default:
				siner++;
				draw_set_color(color);
				draw_set_font(font);
				
				switch (effect) {
					default:
					case 0:
						draw_text_transformed(cx, cy, c, scaleX, scaleY, 0);
						break;
					case 1:
						draw_text_transformed(cx + irandom(1), cy + irandom(1), c, scaleX, scaleY, 0);
						break;
					case 2:
						draw_text_transformed(cx + cos(current_time / 125 + siner) * 1.5, cy + sin(current_time / 125 + siner) * 1.5, c, scaleX, scaleY, 0);
						break;
				}
				
				cx += charWidth;
				break;
		}
	}
}