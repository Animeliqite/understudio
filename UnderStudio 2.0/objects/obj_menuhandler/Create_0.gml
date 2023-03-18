/// @description Initialize

state					= 0;
subState				= 0;
selection				= 0;
prevSelection			= undefined;

namingName				= "";
namingHeader			= dx_getraw("naming_title")
namingLetters			= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
namingOptions			= [dx_getraw("naming_exit"), dx_getraw("naming_backspace"), dx_getraw("naming_done")];
namingRows				= 7;

namingHeaderConfirm		= dx_getraw("naming_title_confirm")
namingOptionsConfirm	= [dx_getraw("naming_confirm"), dx_getraw("naming_cancel")];
namingNameXOffset		= 0;
namingNameYOffset		= 0;
namingNameScale			= 0;

musicFile				= song_load("menu0");
menuMusic				= song_play(musicFile, 1, 1);
tweenExecutedOnce		= false;
cymbalFader				= noone;

settingsCurtainX		= [320, 320];