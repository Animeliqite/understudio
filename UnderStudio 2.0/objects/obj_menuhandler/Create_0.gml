/// @description Initialize

state					= 0;
subState				= 0;
selection				= 0;
prevSelection			= undefined;

namingHeader			= "Name the fallen human."
namingLetters			= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
namingOptions			= [{text: "Exit", action: "EXIT"}, {text: "Backspace", action: "BACKSPACE"}, {text: "Done", action: "DONE"}];
namingRows				= 7;

musicFile				= song_load("menu0");
menuMusic				= song_play(musicFile, 1, 1);

settingsCurtainX		= [320, 320]; 