#region Numbers
function number_add(number, valMax = undefined, incrementAmount = 1) {
    var result = number + incrementAmount;
    return (valMax != undefined) ? min(result, valMax) : result;
}

function number_sub(number, valMin = undefined, decrementAmount = 1) {
    var result = number - decrementAmount;
    return (valMin != undefined) ? max(result, valMin) : result;
}

function number_add_wrap(number, valMin, valMax, incrementAmount = 1) {
    var range = valMax - valMin;
    return valMin + ((number - valMin + incrementAmount) mod range);
}

function number_sub_wrap(number, valMin, valMax, decrementAmount = 1) {
    var range = valMax - valMin;
    return valMin + ((number - valMin - decrementAmount + range) mod range);
}
#endregion

#region Animation
// Similar to lerp, but with linear interpolation
function approach(currValue, targetValue, incrementAmount) {
    if (currValue < targetValue)
        return min(currValue + incrementAmount, targetValue); 
    else
        return max(currValue - incrementAmount, targetValue);
}
#endregion

#region Timers

function timer_set(callback, time_in_frames, args_array) {
    var t = time_source_create(time_source_global, time_in_frames, time_source_units_frames, callback, args_array);
    time_source_start(t);
    return t;
}

function timer_repeat(callback, interval_in_frames, args_array) {
    var t = time_source_create(time_source_global, interval_in_frames, time_source_units_frames, callback, args_array, -1, time_source_expire_after);
    time_source_start(t);
    return t;
}

function timer_stop_safe(timer_id) {
    if (time_source_exists(timer_id)) {
        time_source_stop(timer_id);
        time_source_destroy(timer_id);
    }
}

#endregion

#region Others
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
#endregion