/// @description Initialize

// VARIABLES
state		= 0;
subState	= 0;
battleSong	= song_load("battle");

// FUNCTIONS
screen_fade(1,0,0.25);	// Fade the screen
song_play(battleSong);	// Play the battle song