/// @description Check for seconds

faderSeconds += 1 / game_get_speed(gamespeed_fps);
if (abs(faderDuration - faderSeconds) > abs(faderAlphaTarget - faderAlpha))
	faderAlpha = faderAlphaTarget;