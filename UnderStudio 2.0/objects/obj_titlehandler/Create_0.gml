/// @description Initialize

showTitle			= false;	// Should the object show the "UNDERTALE" text?
showAlternateText	= false;	// Should the object show the hint for going to the next room

alarm[0]			= game_get_speed(gamespeed_fps) / 2;	// Trigger the alarm event for showing the title text
alarm[1]			= game_get_speed(gamespeed_fps) * 1.5;	// Trigger the alarm event for showing the alternate text