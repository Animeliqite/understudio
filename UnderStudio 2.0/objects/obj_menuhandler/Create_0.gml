/// @description Initialize

state					= 0;
subState				= 0;
selection				= 0;
prevSelection			= undefined;

namingName				= "";
namingHeader			= "Name the fallen human."
namingLetters			= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
namingOptions			= ["Exit", "Backspace", "Done"];
namingRows				= 7;

namingHeaderConfirm		= "Is this name correct?"
namingOptionsConfirm	= ["No", "Yes"];
namingNameXOffset		= 0;
namingNameYOffset		= 0;
namingNameScale			= 0;

musicFile				= song_load("menu0");
menuMusic				= song_play(musicFile, 1, 1);
tweenExecutedOnce		= false;
cymbalFader				= noone;

settingsCurtainX		= [320, 320];