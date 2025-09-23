// @description Parse Next Character/Command

// Exit if we have parsed the entire string
if (parser_pos >= string_length(text)) {
    completed = true;
    exit;
}

// Move to the next position in the string
parser_pos++;
var _char = string_char_at(text, parser_pos);

// Check for special commands using backticks
if (_char == "`") {
    parser_pos++;
    var _command = string_char_at(text, parser_pos);
    
    switch (_command) {
        // Pause Command: `pX`
        case "p":
            parser_pos++;
            var _pause_amount = string_char_at(text, parser_pos);
            holdTimer += real(_pause_amount) * 10; // Add to existing timer
            parser_pos++; // Skip the final backtick
            break;
            
        // Event Command: `EX`
        case "E":
            parser_pos++;
            var _event_id = string_char_at(text, parser_pos);
            global.writerEvent = real(_event_id);
            parser_pos++; // Skip the final backtick
            break;
        
        // If it's not a recognized command, treat it as a literal backtick.
        default:
            visible_chars++;
            break;
    }
    // We handled a command, so we call the event again to process the *next* character immediately
    event_user(0);
}
// Check for commands from the new system (e.g., [color:red])
else if (_char == "[") {
    var _command_end = string_pos_ext("]", text, parser_pos);
    if (_command_end > 0) {
        parser_pos = _command_end; // Skip the entire command block
        event_user(0); // Process whatever comes after the command
    }
}
// It's a normal, visible character
else {
    visible_chars++;
    
    // Play voice sound, but not for spaces
    if (_char != " ") {
        // Your original sound logic
        var _voice_count = array_length(voice);
        if (_voice_count > 0) {
            var _sound_to_play = voice[irandom(_voice_count - 1)];
            audio_stop_sound(_sound_to_play); // Optional: stop previous to prevent overlap
            audio_play_sound(_sound_to_play, 1, false);
        }
    }
}