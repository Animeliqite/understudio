/// @description Initialize

// State Machine
state = BATTLE_STATE.BUTTON;
state_next = undefined;
state_executed_once = false;

menu = BATTLE_MENU.NONE;
menu_next = undefined;
menu_executed_once = false;

// Selections
selection_button = 0;
selection_enemy = 0;
selection_act = [0, 0];
selection_item = [0, 0];
selection_spare = 0;

flavorWriter = noone;
flavorText = "* Monsters block the way!";
flavorSpeaker = "none_alt";

// Other
highlight_buttons = false;
battleSong = "battle";

// Flavor speaker specific properties
flavorFace = undefined;
flavorVoice = undefined;
flavorFont = fnt_main;

flavorActionText = "";

battleEnemies = [];

// FUNCTIONS
screen_fade(1,0,15); // Fade the screen
song_play(song_load(battleSong)); // Play the battle song
battle_set_menu_text(flavorText);

// OTHER
event_user(1);

drawMenuText = function (text) {
	flavorActionText = text;
}