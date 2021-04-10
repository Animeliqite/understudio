surface_set_target(global.drawingSurface);
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
	var faceAsset = asset_get_index(face + "_" + string(faceEmotion));
	
	if (face != "") {
		if (sprite_exists(faceAsset)) {
			draw_sprite_part_ext(faceAsset, faceIndex, 0, 0, 104, 104, x, y, 2, 2, c_white, 1);
		}
	}
	
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
			case "f": // Face
				var cmdOperand = string_char_at(drawString, ++i);
				var cmdOperandAfter = string_char_at(drawString, ++i);
				var newFace;
				switch (cmdOperand)
				{
					case "$":
						newFace = "";
						break;
					case "S":
						newFace = "spr_face_sans";
						break;
					case "P":
						newFace = "spr_face_papyrus";
						break;
					case "U":
						newFace = "spr_face_undyne";
						break;
					default:
						newFace = "";
						break;
				}
				face = newFace;
				faceEmotion = real(cmdOperandAfter);
				break;
			/*case "$": // Button Sprite
				if (gamepad_is_connected(gamepad_get_device_count())) {
					draw_sprite_ext(buttonSprite, 0, _x, _y + (sprite_get_height(buttonSprite) / 4), 2, 2, 0, c_white, 1);
					_x += sprite_get_width(buttonSprite) + (charWidth * 3);
				}
				else
					string_insert(buttonString, drawString, ++i);
				break;*/
			case "s": // Text Spacing
				var cmdOperand = string_char_at(drawString, ++i);
				var cmdOperandAfter = string_char_at(drawString, ++i);
				
				var spaceX = 1;
				var spaceY = 1;
				var str = "";
				
				switch (cmdOperand)
				{
					case "X":
						while (i <= len && (string_char_at(drawString, i - 1) != "`")) {
							str += string_char_at(drawString, ++i - 1);
							i--;
							if (string_char_at(drawString, ++i) == "`") {
								spaceX = real(str);
								charSpaceX = spaceX;
							}
						}
						break;
					case "Y":
						while (i <= len && (string_char_at(drawString, i - 1) != "`")) {
							str += string_char_at(drawString, ++i - 1);
							i--;
							if (string_char_at(drawString, ++i) == "`") {
								spaceY = real(str);
								charSpaceY = spaceY;
							}
						}
						break;
				}
				break;
			default:
				i += 2;
				break;
		}
	} else if (c == "&") || ((_x > textBounds[3]) && (mustBeInBounds))
	{
		// Newline
		_x = x;
		_y += charHeight * 2 * charSpaceY;
	} else
	{
		charSiner++;
		switch (effect)
		{
			case 1:
				draw_text(_x + (face != "" ? 104 : 0) + irandom(0.5) - 1, _y + irandom(0.5) - 1, c);
				break;
			case 2:
				draw_text(_x + (face != "" ? 104 : 0) + cos(charSiner) - 1, _y + sin(charSiner) - 1, c);
				break;
			default:
				draw_text(_x + (face != "" ? 104 : 0), _y, c);
				break;
		}
		_x += charWidth * 2 * charSpaceX;
	}
}
surface_reset_target();