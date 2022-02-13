function game_init(){
	/*
		In here, like in the initialization object, we can change some variables for quick access to
		testing newly made stuff. Changing some variables might break the game, so be careful!
	*/
	
	// MANAGERS
	global.windowManager = new WindowManager(); // The window manager
	global.musicManager = new MusicManager(); // The main music manager
	//global.langManager = new LangManager(); // The main sound effect manager
	global.sfxManager = new SFXManager(); // The main sound effect manager
	
	// BORDER
	global.border = false; // Is the border enabled?_
	global.borderSprites = {current: undefined, next: undefined}; // Border sprite struct
	global.borderOpacities = {current: 1, next: 0}; // Border opacity struct
	
	// WINDOW
	global.windowType = WINDOW_TYPE.NORMAL; // The current window type
	global.windowSize = global.windowManager.GetSize(); // The current window size
	global.windowX = window_get_x(); // The current window X
	global.windowY = window_get_y(); // The current window Y
	
	// LOCALIZATION
	global.localizationFilePath = "lang/"; // The path to get all the JSON's from
	global.localizationData = language_util(); // The entire localization data
	
	// INPUT
	input_init(); // Initialize the input system
	input_update(); // Update the input system once
	
	// CUTSCENE
	global.cutscene = false; // Is the cutscene enabled?
	global.cutsceneOrder = []; // The order to execute one by one while a cutscene is playing
	
	// AUDIO
	audio_channel_num(128); // Set the maximum audio channel number
	global.sfxEmitter = audio_emitter_create(); // The emitter for various sound effects
	global.songEmitter = audio_emitter_create(); // The emitter for various songs
	global.musicFilePath = "mus/"; // The path to get all the songs from
	global.currentSong = -1; // The current song that is playing
	
	// PLAYER
	global.playerName = "Chara"; // The player name
	global.playerHP = {current: 20, maximum: 20}; // The player HP
	global.playerLV = 1; // The player level
	global.playerEXP = 0; // The player's execution points
	global.playerNEXT = 10; // The player's amount of EXP to get to the next level
	global.playerAT = 10; // The player's attacking strength
	global.playerDF = 10; // The player's defending strength
	
	// OTHER
	window_set_color(c_black); // Set the window color
	surface_resize(application_surface, 640, 480); // Resize the application surface
	application_surface_draw_enable(false); // Disable automatically drawing the application surface
	display_set_gui_size(640, 480); // Set the GUI size
	global.windowManager.UpdateSize();
	
	// EVENTS
	global.writerEvent = undefined; // The event number caused by the writer
	
	// FONT
	global.mainFontWidth = 16; // The main font width (8-Bit Operator JVE)
	global.mainFontHeight = 36; // The main font height (8-Bit Operator JVE)
}