/// @description Initialize

state					= 0;
subState				= 0;
selection				= 0;
prevSelection			= undefined;

namingName				= "";
namingHeader			= dx_getraw("menu_screen","naming_title")
namingLetters			= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
namingOptions			= [dx_getraw("menu_screen","naming_exit"), dx_getraw("menu_screen","naming_backspace"), dx_getraw("menu_screen","naming_done")];
namingRows				= 7;

namingHeaderConfirm		= dx_getraw("menu_screen","naming_title_confirm")
namingOptionsConfirm	= [dx_getraw("menu_screen","naming_decline"), dx_getraw("menu_screen","naming_confirm")];
namingNameXOffset		= 0;
namingNameYOffset		= 0;
namingNameScale			= 0;

musicFile				= song_load("menu0");
menuMusic				= song_play(musicFile, 1, 1);
tweenExecutedOnce		= false;
cymbalFader				= noone;

settingsCurtainX		= [320, 320];