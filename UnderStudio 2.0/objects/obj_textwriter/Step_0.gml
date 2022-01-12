/// @description Hold Timer

if (currentPos < string_length(text) + 2) {
	if (holdTimer > 0)
		holdTimer--;
	else {
		holdTimer = textSpeed;
		currentPos++;
		event_user(0); // Write the text
	}
}