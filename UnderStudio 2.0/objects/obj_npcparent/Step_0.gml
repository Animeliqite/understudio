/// @description Functionality

if (isSpeaking) {
	_onSpeak();
	speakingExecutedOnce = false;
}
else {
	if (!speakingExecutedOnce) {
		_onSpeakEnd();
		speakingExecutedOnce = true;
	}
}