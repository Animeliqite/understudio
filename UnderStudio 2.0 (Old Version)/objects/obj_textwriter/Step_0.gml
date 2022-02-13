/// @description Hold Timer

// Check whether the writer has completed writing
if (!completed) {
	// Skip the entire writing process if skipping is set to true
	if (skipText && skippable) {
		repeat (string_length(text) + 2 - currentPos) {
			currentPos++;
			event_user(0);
		}
	}
	
	// Wait for the timer to end
	if (holdTimer > 0)
		holdTimer--;
	else {
		holdTimer = textSpeed;
		currentPos++;
		event_user(0); // Write the text
	}
}