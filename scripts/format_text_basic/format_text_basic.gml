/// @description format_text_basic(text[, punctuation[, asterisk]])
/// @param text[
/// @param punctuation[
/// @param asterisk]]
/// Formats dialogue with timing and asterisk newlines

function format_text_basic()
{
	var in = argument[0];
	var out = "";
	var punc = true;
	var aster = true;
	if (argument_count > 1)
	{
	    punc = argument[1];
	    if (argument_count > 2)
	        aster = argument[2];
	}
	
	var len = string_length(in);
	var state = 0;
	var formatState = 0;
	var isPeriod = false;
	for (var i = 1; i <= len; i++)
	{
	    var currChar = string_char_at(in, i);
		if (state == 2 && (currChar == "\\" || currChar == "`"))
			state = 0;
	    switch (state)
	    {
	        case 0:
	            switch (currChar)
	            {
	                case " ":
	                    if (aster)
	                        state = 1;
	                    else
	                        out += currChar;
	                    break;
	                case "\\": // escape, for punctuation or not
	                    i++;
	                    currChar = string_char_at(in, i);
	                    if (currChar == "&")
	                        out += ("\\" + currChar);
	                    else
	                        out += currChar;
	                    break;
	                case "`":
	                    var _con = (i + 1) <= len;
	                    var nc;
	                    if (_con)
	                        nc = string_char_at(in, i + 1);
	                    if (_con && nc == "$")
	                        state = 4;
	                    else if (_con && nc == "@")
	                    {
	                        out += "`";
	                        punc = !punc;
	                    } else
	                    {
	                        out += "`";
	                        state = 3;
	                    }
	                    break;
	                default:
	                    out += currChar;
						if (punc && in_array(global.lang_punctuation, currChar))
						{
	                        isPeriod = (currChar == global.lang_period);
	                        state = 2;
						}
	                    break;
	            }
	            break;
	        case 1: // Asterisk newline check
	            state = 0;
	            if (currChar == global.lang_asterisk)
	            {
	                out += "&" + currChar;
	            } else
	            {
	                out += " ";
	                i--; // Redo this character with 0 state
	                break;
	            }
	            break;
	        case 2: // Punctuation add pause
	            if (!in_array(global.lang_punctuation, currChar))
	            {
	                if (isPeriod && currChar != " ")
	                {
	                    out += currChar;
	                    state = 0;
	                    break;
	                }
	                out += "`p1`";
	                state = 0;
	                i--; // Redo this character with 0 state
	                break;
	            }
	            out += currChar;
	            break;
	        case 3: // Ignore/passthrough styling
	            out += currChar;
	            if (currChar == "`")
	                state = 0;
	            break;
	        case 4: // Process format strings
	            if (formatState == 1)
	            {
	                out += global.format[real(currChar)];
	            } else if (formatState == 2)
	            {
	                formatState = 0;
	                state = 0;
	                break;
	            }
	            formatState++;
	            break;
	    }
	}

	return out;
}
