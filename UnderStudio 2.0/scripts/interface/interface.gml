/// @function draw_text_extended(x, y, text, args)
/// @description Draws text with special commands and automatic word wrapping.
/// @param {Real} x The starting x-coordinate.
/// @param {Real} y The starting y-coordinate.
/// @param {String} text The text to draw, including commands like [color:red].
/// @param {Struct} args A struct containing all drawing arguments.
/*
    args struct format:
    {
        halign:         Text alignment (fa_left, fa_center, fa_right),
        valign:         Text alignment (fa_top, fa_middle, fa_bottom),
        size:           Overall text scale multiplier,
        visible:        The amount of characters to show (for typewriter effects),
        font:           The font asset to use,
        alpha:          The overall text transparency (0-1),
        color:          The default text color,
        effect:         The default effect ("none", "wavy", "shaky"),
		letter_width:   Letter width in pixels
		letter_height:  Letter height in pixels
        letter_spacing: Multiplier for space between letters,
        line_spacing:   Multiplier for space between lines,
        line_break:     The width in pixels at which to wrap text. -1 to disable.
    }
*/
function draw_text_extended(_x, _y, _text, _args) {

    // --- 1. ARGUMENT & STATE INITIALIZATION ---
    
    // Set drawing properties from the args struct
    draw_set_font(_args.font);
    draw_set_halign(_args.halign);
    draw_set_valign(_args.valign);

    var _line_height = (_args.letter_height != -1 ? _args.letter_height : string_height(" ")) * _args.line_spacing;
    
    // Pre-calculate the total width of each line for alignment
    var _lines_meta = [];
    if (_args.halign != fa_left) {
        _lines_meta = _calculate_line_widths(_text, _args);
    }

    // Adjust starting X based on horizontal alignment for the first line
    var _draw_x_start = _x;
    if (_args.halign == fa_center) {
        if (array_length(_lines_meta) > 0) _draw_x_start -= _lines_meta[0].width / 2;
    } else if (_args.halign == fa_right) {
        if (array_length(_lines_meta) > 0) _draw_x_start -= _lines_meta[0].width;
    }
    
    // Current drawing position and state
    var _draw_x = _draw_x_start;
    var _draw_y = _y;
    var _chars_drawn = 0;
    var _line_index = 0;
    
    // Active drawing state, initialized from args
    var _current_color = _args.color;
    var _current_alpha = _args.alpha;
    var _current_size = _args.size;
    var _current_effect = _args.effect;
    var _has_line_break = (_args.line_break ?? -1) > 0;
    
    // --- 2. MAIN DRAWING LOOP ---

    var i = 1;
    while (i <= string_length(_text)) {
        
        if (_chars_drawn >= _args.visible) break;

        var _char = string_char_at(_text, i);

        // --- 2A. COMMAND PARSING ---
        if (_char == "[") {
            var _command_end = string_pos_ext("]", _text, i); // CORRECTED
            if (_command_end > 0) {
                var _command_str = string_copy(_text, i + 1, _command_end - i - 1);
                var _colon_pos = string_pos(":", _command_str);
                
                if (_colon_pos > 0) {
                    var _key = string_lower(string_copy(_command_str, 1, _colon_pos - 1));
                    var _value = string_lower(string_copy(_command_str, _colon_pos + 1, string_length(_command_str)));
                    
                    switch (_key) {
                        case "color": _current_color = get_color_from_string(_value); break;
                        case "effect": _current_effect = _value; break;
                        case "size": _current_size = real(_value) * _args.size; break;
                    }
                }
                i = _command_end + 1; // Jump parser past the command
                continue;
            }
        }

        // --- 2B. HANDLE NEWLINES & SPACES ---
        if (_char == "\n") {
            _line_index++;
            _draw_y += _line_height * _current_size;
            _draw_x = _x; // Reset X for the new line
            // Re-apply alignment for the new line
            if (_args.halign == fa_center) {
                if (array_length(_lines_meta) > _line_index) _draw_x -= _lines_meta[_line_index].width / 2;
            } else if (_args.halign == fa_right) {
                if (array_length(_lines_meta) > _line_index) _draw_x -= _lines_meta[_line_index].width;
            }
            i++;
            continue;
        }
        
        if (_char == " ") {
            _draw_x += (_args.letter_width != -1 ? _args.letter_width : string_width(_word_char)) * _current_size;
            _chars_drawn++;
            i++;
            continue;
        }

        // --- 2C. WORD WRAPPING LOGIC ---
        var _word_end = string_pos_ext(" ", _text, i); // CORRECTED
        var _newline_pos = string_pos_ext("\n", _text, i); // CORRECTED
        if (_word_end == 0) _word_end = string_length(_text) + 1;
        if (_newline_pos > 0 && _newline_pos < _word_end) _word_end = _newline_pos;

        var _word = string_copy(_text, i, _word_end - i);
        var _word_width = _calculate_word_width(_word, _current_size, _args);

        if (_has_line_break && (_draw_x + _word_width) > (_draw_x_start + _args.line_break) && _draw_x > _draw_x_start) {
            _line_index++;
            _draw_y += _line_height * _current_size;
            _draw_x = _x; // Reset X for the new line
            // Re-apply alignment for the new line
            if (_args.halign == fa_center) {
                if (array_length(_lines_meta) > _line_index) _draw_x -= _lines_meta[_line_index].width / 2;
            } else if (_args.halign == fa_right) {
                if (array_length(_lines_meta) > _line_index) _draw_x -= _lines_meta[_line_index].width;
            }
        }

        // --- 2C. DRAW WORD CHARACTER BY CHARACTER (WITH COMMAND PARSING) ---
        var j = 1;
        while (j <= string_length(_word)) {
            if (_chars_drawn >= _args.visible) break;
            
            var _word_char = string_char_at(_word, j);
            
            // *** BUG FIX: PARSE COMMANDS INSIDE THE WORD ***
            if (_word_char == "[") {
                var _command_end = string_pos_ext("]", _word, j);
                if (_command_end > 0) {
                    var _command_str = string_copy(_word, j + 1, _command_end - j - 1);
                    var _colon_pos = string_pos(":", _command_str);
                    
                    if (_colon_pos > 0) {
                        var _key = string_lower(string_copy(_command_str, 1, _colon_pos - 1));
                        var _value = string_lower(string_copy(_command_str, _colon_pos + 1, string_length(_command_str)));
                        
                        switch (_key) {
                            case "color": _current_color = get_color_from_string(_value); break;
                            case "effect": _current_effect = _value; break;
                            case "size": _current_size = real(_value) * _args.size; break;
                        }
                    }
                    j = _command_end + 1; // Jump parser past the command
                    continue;
                }
            }

            // It's a normal character, draw it
            var _char_width = (_args.letter_width != -1 ? _args.letter_width : string_width(_word_char)); 
            var _x_offset = 0;
            var _y_offset = 0;
            
            switch (_current_effect) {
                case "shaky":
                    _x_offset = random_range(-1, 1) * _current_size;
                    _y_offset = random_range(-1, 1) * _current_size;
                    break;
				case "part_shaky":
					if (random(100) > 98) {
	                    _x_offset = random_range(-1, 1) * _current_size;
	                    _y_offset = random_range(-1, 1) * _current_size;
					}
					else {
						_x_offset = 0;
	                    _y_offset = 0;
					}
                    break;
                case "wavy":
                    _x_offset = cos((current_time / 250) + (_draw_x / 20)) * 2 * _current_size;
                    _y_offset = sin((current_time / 250) + (_draw_x / 20)) * 2 * _current_size;
                    break;
            }
			
            draw_ftext(_draw_x + _x_offset, _draw_y + _y_offset, _word_char, _args.font, _current_color, _args.alpha, _current_size, _current_size, 0);
			
            _draw_x += (_char_width * _current_size) + _args.letter_spacing;
            _chars_drawn++;
            j++;
        }
        
        i = _word_end; // Move main index past the word we just drew
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// --- 3. HELPER FUNCTIONS ---

/// @function _calculate_word_width(word, start_size, args)
/// @description Calculates the rendered width of a single word, including commands.
function _calculate_word_width(_word, _start_size, _args) {
    var _width = 0;
    var _size = _start_size;
    for (var k = 1; k <= string_length(_word); k++) {
        var _char = string_char_at(_word, k);
        if (_char == "[") {
            var _cmd_end = string_pos_ext("]", _word, k); // CORRECTED
            if (_cmd_end > 0) {
                var _cmd_str = string_copy(_word, k + 1, _cmd_end - k - 1);
                var _col_pos = string_pos(":", _cmd_str);
                if (_col_pos > 0) {
                    var _key = string_lower(string_copy(_cmd_str, 1, _col_pos - 1));
                    if (_key == "size") {
                        var _val = string_copy(_cmd_str, _col_pos + 1, string_length(_cmd_str));
                        _size = real(_val) * _args.size;
                    }
                }
                k = _cmd_end;
                continue;
            }
        }
        _width += ((_args.letter_width != -1 ? _args.letter_width : string_width(_char)) * _size) + _args.letter_spacing;
    }
    return _width;
}

/// @function _calculate_line_widths(text, args)
/// @description Pre-calculates the width of each wrapped line for alignment.
function _calculate_line_widths(_text, _args) {
    var _lines = [];
    var _line_width = 0;
    var _current_size = _args.size;
    var _has_line_break = (_args.line_break ?? -1) > 0;
    var i = 1;
    while (i <= string_length(_text)) {
        var _char = string_char_at(_text, i);
        if (_char == "[") {
            var _cmd_end = string_pos_ext("]", _text, i); // CORRECTED
            if (_cmd_end > 0) {
                var _cmd_str = string_copy(_text, i + 1, _cmd_end - i - 1);
                var _col_pos = string_pos(":", _cmd_str);
                if (_col_pos > 0) {
                    var _key = string_lower(string_copy(_cmd_str, 1, _col_pos - 1));
                    if (_key == "size") {
                        var _val = string_copy(_cmd_str, _col_pos + 1, string_length(_cmd_str));
                        _current_size = real(_val) * _args.size;
                    }
                }
                i = _cmd_end + 1;
                continue;
            }
        }
        
        if (_char == "\n") {
            array_push(_lines, { width: _line_width });
            _line_width = 0;
            i++;
            continue;
        }
        
        if (_char == " ") {
            _line_width += string_width(" ") * _current_size;
            i++;
            continue;
        }

        var _word_end = string_pos_ext(" ", _text, i); // CORRECTED
        var _newline_pos = string_pos_ext("\n", _text, i); // CORRECTED
        if (_word_end == 0) _word_end = string_length(_text) + 1;
        if (_newline_pos > 0 && _newline_pos < _word_end) _word_end = _newline_pos;
        
        var _word = string_copy(_text, i, _word_end - i);
        var _word_width = _calculate_word_width(_word, _current_size, _args);

        if (_has_line_break && (_line_width + _word_width) > _args.line_break && _line_width > 0) {
            array_push(_lines, { width: _line_width });
            _line_width = 0;
        }

        _line_width += _word_width;
        i = _word_end;
    }
    array_push(_lines, { width: _line_width });
    return _lines;
}


/// @function get_color_from_string(color_string)
/// @description Converts a string name into a Game Maker color constant.
function get_color_from_string(_color_string) {
    switch (_color_string) {
        case "white": return c_white;
        case "black": return c_black;
        case "red": return c_red;
        case "green": return c_green;
        case "blue": return c_blue;
        case "yellow": return c_yellow;
        case "aqua": return c_aqua;
        case "fuchsia": return c_fuchsia;
        case "orange": return c_orange;
        case "purple": return c_purple;
        case "lime": return c_lime;
        case "maroon": return c_maroon;
        case "navy": return c_navy;
        case "olive": return c_olive;
        case "teal": return c_teal;
        case "gray": return c_gray;
        case "silver": return c_silver;
        default: return c_white; // Default if color not found
    }
}


function draw_ftext(_x, _y, text, font = fnt_main, color = c_white, alpha = 1, xscale = 1, yscale = 1, angle = 0, halign = fa_left, valign = fa_top) {
	// Initialize the variables
	var prevFont = draw_get_font(),
		prevAlpha = draw_get_alpha(),
		prevColor = draw_get_color(),
		prevHAlign = draw_get_halign(),
		prevVAlign = draw_get_valign();
	
	// Initialize everything
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_alpha(alpha);
	draw_set_color(color);
	
	// Draw the text
	draw_text_transformed(_x, _y, text, xscale, yscale, angle);
	
	// Reset values
	draw_set_font(prevFont);
	draw_set_halign(prevHAlign);
	draw_set_valign(prevVAlign);
	draw_set_alpha(prevAlpha);
	draw_set_color(prevColor);
}

function draw_box(_x1, _y1, _x2, _y2, outlineLength = 6, func = {sprite: undefined, borderColor: c_white, bgColor: c_black}) {
	// Initialize the variables
	var prevColor = draw_get_color();
	
	// Draw the box
	if (is_undefined(func.sprite)) {
		draw_set_color(func.borderColor);
		draw_rectangle(_x1, _y1, _x2, _y2, false);
		draw_set_color(func.bgColor);
		draw_rectangle(_x1 + outlineLength, _y1 + outlineLength, _x2 - outlineLength, _y2 - outlineLength, false);
	}
	else draw_sprite_stretched_ext(func.sprite, 0, _x1, _y1, _x2 - _x1, _y2 - _y1, c_white, 1);
	
	// Reset values
	draw_set_color(prevColor);
}