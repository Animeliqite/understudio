/// @description Hold Timer

if (!completed) {
	if (skipText) {
		repeat (string_length(text) + 2 - currentPos) {
			currentPos++;
			event_user(0);
		}
	}
	
	if (holdTimer > 0)
		holdTimer--;
	else {
		holdTimer = textSpeed;
		currentPos++;
		event_user(0); // Write the text
	}
}