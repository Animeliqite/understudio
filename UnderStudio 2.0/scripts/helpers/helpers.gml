function number_add(number, valMax = undefined, incrementAmount = 1) {
	if (!is_undefined(valMax)) {
		if (number < valMax) && (!is_undefined(valMax)) {
			if (number + incrementAmount >= valMax)
				number = valMax;
			else number += incrementAmount;
		}
	}
	else number += incrementAmount;
	
	return number;
}

function number_sub(number, valMin = undefined, decrementAmount = 1) {
	if (!is_undefined(valMin)) {
		if (number > valMin) {
			if (number - decrementAmount <= valMin)
				number = valMin;
			else number -= decrementAmount;
		}
	}
	else number -= decrementAmount;
	
	return number;
}

// Similar to lerp, but with linear interpolation
function approach(currValue, targetValue, incrementAmount) {
    if (currValue < targetValue)
        return min(currValue + incrementAmount, targetValue); 
    else
        return max(currValue - incrementAmount, targetValue);
}

/// Smart-format text with grouped dots
function format_text_with_pauses(_txt) {
    var out = "";
    var i   = 1;
    var L   = string_length(_txt);
    
    while (i <= L) {
        var c = string_char_at(_txt, i);
        
        // if it’s a dot, grab the whole run
        if (c == ".") {
            var j = i;
            // find end of dot-run
            while (j <= L && string_char_at(_txt, j) == ".") {
                j++;
            }
            // copy the run (+ one pause)
            out += string_copy(_txt, i, j - i) + "`p1`";
            i = j;
            
        // else if any other punctuation, just do normal
        } else if (c == "," || c == ":" || c == ";" || c == "!" || c == "?") {
            out += c + "`p1`";
            i++;
            
        // otherwise copy char as-is
        } else {
            out += c;
            i++;
        }
    }
    
    return out;
}

function instance_find_equal_value(object, variable, value) {
	for (var i = 0; i < instance_number(object); i++) {
		if (variable_instance_get(instance_find(object, i), variable) == value) {
			return instance_find(object, i);
		}
	}
}

// Gets the array index from the value
function array_index_of(_array, _value) {
    for (var i = 0; i < array_length(_array); i++) {
        if (_array[i] == _value) return i;
    }
    return -1;
}
