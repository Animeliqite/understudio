surface_set_target(global.drawingSurface);
draw_set_font(font);
draw_set_color(baseColor);
charSiner = current_time / (room_speed * 5);

_x = x;
_y = y;

var effect = textEffect;
var len = string_length(drawString);
var faceAsset = asset_get_index(face + "_" + string(faceEmotion));

if (face != "") {
	if (sprite_exists(faceAsset)) {
		draw_sprite_part_ext(faceAsset, faceIndex, 0, 0, 104, 104, x, y + (sprite_get_height(faceAsset) / 4), 2, 2, c_white, 1);
	}
}
	
for (var i = 1; i <= len; i++)
{	
    var c = string_char_at(drawString, i);
	
	if (c == "`")
	{
		// Command: parse it
		var cmdType = string_char_at(drawString, ++i);
		switch (cmdType)
		{
			case "p":
				i += 2;
				break;
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
			case "F": // Font
				var cmdOperand = string_char_at(drawString, ++i);
				var newFont;
				switch (cmdOperand)
				{
					case "$":
						newFont = fnt_dialogue;
						charWidth = 8;
						charHeight = 18;
						textSound = [snd_text_default];
						break;
					case "S":
						newFont = fnt_comicsans;
						charWidth = 8;
						charHeight = 18;
						textSound = [snd_text_sans];
						break;
					case "P":
						newFont = fnt_papyrus;
						charWidth = 11;
						charHeight = 18;
						textSound = [snd_text_papyrus];
						break;
					default:
						newFont = fnt_dialogue;
						break;
				}
				font = newFont;
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
				break;
		}
	} else if (c == "&") || ((_x > textBounds[3]) && (mustBeInBounds))
	{
		// Newline
		_x = x;
		_y += charHeight * 2 * charSpaceY;
	} else
	{
		if (font == fnt_comicsans) {
			if (c == "w")
                _x += 2;
            if (c == "m")
                _x += 2;
            if (c == "i")
                _x -= 2;
            if (c == "l")
                _x -= 2;
            if (c == "s")
                _x -= 1;
            if (c == "j")
                _x -= 1;
        }
        else if (font == fnt_papyrus) {
            if (c == "D")
                _x += 1;
            if (c == "Q")
                _x += 3;
            if (c == "M")
                _x += 1;
            if (c == "L")
                _x -= 1;
            if (c == "K")
                _x -= 1;
            if (c == "C")
                _x += 1;
            if (c == ".")
                _x -= 3;
            if (c == "!")
                _x -= 3;
            if (c == "O" || c == "W")
                _x += 2;
            if (c == "I")
                _x -= 6;
            if (c == "T")
                _x -= 1;
            if (c == "P")
                _x -= 2;
            if (c == "R")
                _x -= 2;
            if (c == "A")
                _x += 1;
            if (c == "H")
                _x += 1;
            if (c == "B")
                _x += 1;
            if (c == "G")
                _x += 1;
            if (c == "F")
                _x -= 1;
            if (c == "?")
                _x -= 3;
            if (c == "'")
                _x -= 6;
            if (c == "J")
                _x -= 1;
        }
		
		var isDiaOrSpeech = (font != fnt_dialogue && font != fnt_speech);
		charSiner++;
		switch (effect)
		{
			case 1:
				draw_text_transformed(_x + (face != "" ? 104 : 0) + random_range(-0.5, 0.5) - 1, _y + random_range(-0.5, 0.5) - 1, c, (isDiaOrSpeech ? 2 : 1), (isDiaOrSpeech ? 2 : 1), 0);
				break;
			case 2:
				draw_text_transformed(_x + (face != "" ? 104 : 0) + cos(charSiner) - 1, _y + sin(charSiner) - 1, c, (isDiaOrSpeech ? 2 : 1), (isDiaOrSpeech ? 2 : 1), 0);
				break;
			case 3:
				randomize();
				var chances = random(100);
				if (chances > 99)
					draw_text_transformed(_x + (face != "" ? 104 : 0) + random_range(-0.5, 0.5) - 1, _y + random_range(-0.5, 0.5) - 1, c, (isDiaOrSpeech ? 2 : 1), (isDiaOrSpeech ? 2 : 1), 0);
				else
					draw_text_transformed(_x + (face != "" ? 104 : 0), _y, c, (isDiaOrSpeech ? 2 : 1), (isDiaOrSpeech ? 2 : 1), 0);
				break;
			default:
				draw_text_transformed(_x + (face != "" ? 104 : 0), _y, c, (isDiaOrSpeech ? 2 : 1), (isDiaOrSpeech ? 2 : 1), 0);
				break;
		}
		_x += charWidth * 2 * charSpaceX;
	}
}
surface_reset_target();