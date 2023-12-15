/// @description Initialize

// VARIABLES
state		= 0;					// The current state
subState	= 0;					// The current sub state
subSubState	= 0;					// The current menu state
selection	= 0;					// The current selection
battleSong	= "battle";				// The battle song

flavorWriter	= noone;
flavorText		= "* Monsters block the way!";
flavorFace		= undefined;
flavorVoice		= [snd_alternatevoice];
flavorFont		= fnt_main;

flavorActionText = "";

battleEnemies	= [];
chosenEnemy		= 0;

// FUNCTIONS
screen_fade(1,0,0.25);				// Fade the screen
song_play(song_load(battleSong));	// Play the battle song
dialogue_simple(flavorText, undefined, [snd_alternatevoice], fnt_main, true);

// OTHER
event_user(1);

drawMenuText = function (text) {
	flavorActionText = text;
}