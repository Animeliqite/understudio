draw_set_font(font);
draw_set_color(baseColor);

charSiner = current_time / (room_speed * 5);

_x = x;
_y = y;
var effect = textEffect;
var len = string_length(drawString);

for (var i = 1; i <= len; i++)
{	
    var c = string_char_at(drawString, i);
	if (c == "`")
	{
		// Command: parse it
		var cmdType = string_char_at(drawString, ++i);
		switch (cmdType)
		{
			case "e": // Effect
				var cmdOperand = string_char_at(drawString, ++i);
				effect = real(cmdOperand);
				break;
			case "c": // Color
				var cmdOperand = string_char_at(drawString, ++i);
				var color;
				switch (cmdOperand)
				{
					case "$":
						color = baseColor;
						break;
					case "B":
						color = c_blue;
						break;
					case "b":
						color = c_black;
						break;
					case "W":
						color = c_white;
						break;
					case "Y":
						color = c_yellow;
						break;
					case "R":
						color = c_red;
						break;
					case "G":
						color = c_green;
						break;
					case "g":
						color = c_gray;
						break;
					case "h":
						color = c_ltgray;
						break;
					default:
						color = 0;
						break;
				}
				draw_set_color(color);
				break;
		}
	} else if (c == "&") || ((_x > textBounds[3]) && (mustBeInBounds))
	{
		// Newline
		_x = x;
		_y += charHeight * 2;
	} else
	{
		charSiner++;
		switch (effect)
		{
			case 1:
				draw_text(_x + irandom(0.5) - 1, _y + irandom(0.5) - 1, c);
				break;
			case 2:
				draw_text(_x + cos(charSiner) - 1, _y + sin(charSiner) - 1, c);
				break;
			default:
				draw_text(_x, _y, c);
				break;
		}
		_x += charWidth * 2;
	}
}
