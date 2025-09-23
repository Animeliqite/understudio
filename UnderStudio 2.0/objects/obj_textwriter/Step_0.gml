// @description Update Typewriter State

if (completed) exit;

// Skip the entire writing process if skipping is enabled
if (skipText && skippable) {
    visible_chars = string_length(raw_text); // Reveal all visible characters
    parser_pos = string_length(text);        // Move parser to the end
    completed = true;                        // Mark as complete
    exit;
}
	
// Wait for the timer to end
if (holdTimer > 0) {
    holdTimer--;
}
// Timer is done, reveal one or more characters
else {
    holdTimer = max(0, textSpeed); // Reset timer
    
    var _reveal_amount = (textSpeed < 0) ? -textSpeed + 1 : 1;
    
    repeat (_reveal_amount) {
        if (!completed) {
            event_user(0); // Call the "Write" event
        }
    }
}