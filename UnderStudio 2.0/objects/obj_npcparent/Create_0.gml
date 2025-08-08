/// @description Initialize

// General Settings
image_index	= 0;
image_speed	= 0;

// Advanced Settings
isSpeaking = false;
showSpeakAnim = true;
speakingExecutedOnce = false;

requiredDir = undefined;
currDir = DIR_DOWN;
solidObj = noone;

alarm[0] = 1;

_onSpeak = function () {
	if (showSpeakAnim) {
		image_speed = 0.25;
	}
}

_onSpeakEnd = function () {
	image_speed = 0;
	image_index = 0;
}
