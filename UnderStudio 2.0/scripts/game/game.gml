function game_init(){
	/*
		In here, like in the initialization object, we can change some variables for quick access to
		testing newly made stuff. Changing some variables might break the game, so be careful!
	*/
	
	// BORDER
	global.border = false; // Is the border enabled?_
	global.borderSprites = {current: undefined, next: undefined}; // Border sprite struct
	global.borderOpacities = {current: 1, next: 0}; // Border opacity struct
	
	// WINDOW
	global.windowType = WINDOW_TYPE.NORMAL; // The current window type
	global.windowSize = window_get_size(); // The current window size
	global.windowX = window_get_x(); // The current window X
	global.windowY = window_get_y(); // The current window Y
	
	// DIANNEX
	global.dxData = new DiannexData(); // All the Diannex data
	global.dxData.loadFromFile("dx/game.dxb"); // Load the Diannex File
	global.dxInterpreter = global.dxData.defaultInterpreter; // All the Diannex interpreter
	global.dxInstructions = global.dxData.instructions; // All the Diannex interpreter
	dx_cmd();
	
	// LOCALIZATION
	global.localizationFilePath = "lang/"; // The path to get all the JSON's from
	global.localizationData = language_util(); // The entire localization data
	
	// INPUT
	input_init(); // Initialize the input system
	input_update(); // Update the input system once
	
	// CUTSCENE
	global.inCutscene = false;
	global.currCutscenePhase = 0;
	global.currCutsceneEditingPhase = 0;
	global.cutsceneWaitingForNextPhase = false;
	global.cutsceneWaitingForConditionResult = false;
	global.cutsceneExecutedFromObject = array_create(128, noone);
	global.cutsceneIncrementationWaitTime = array_create(128, 0);
	global.cutsceneConditionResult = array_create(128, "NEXT");
	global.cutsceneConditionResultAsSet = array_create(128, 0);
	global.cutsceneConditionIsGlobal = array_create(128, false);
	global.cutsceneCondition = array_create(128, undefined);
	global.cutscene = array_create(128);
	for (var i = 0; i <= 128; i++)
		global.cutscene[i] = [[],[]]
	
	// AUDIO
	audio_channel_num(128); // Set the maximum audio channel number
	global.sfxEmitter = audio_emitter_create(); // The emitter for various sound effects
	global.songEmitter = audio_emitter_create(); // The emitter for various songs
	global.musicFilePath = "mus/"; // The path to get all the songs from
	global.currentSong = -1; // The current song that is playing
	
	// PLAYER
	global.playerName = "Chara"; // The player name
	global.playerHP = {_curr: 20, _max: 20}; // The player HP
	global.playerLV = 1; // The player level
	global.playerEXP = 0; // The player's execution points
	global.playerNEXT = 10; // The player's amount of EXP to get to the next level
	global.playerAT = 10; // The player's attacking strength
	global.playerDF = 10; // The player's defending strength
	global.playerGold = 0; // The player's gold
	global.playerWeapon = WEAPON.STICK; // The player's current weapon
	global.playerArmor = ARMOR.BANDAGE; // The player's current armor
	global.playerATWeapon = 0; // The player's weapon attacking strength
	global.playerDFArmor = 0; // The player's armor defending strength
	global.playerInventory = ds_list_create(); // The player's inventory
	
	
	// OTHER
	window_set_color(c_black); // Set the window color
	surface_resize(application_surface, 640, 480); // Resize the application surface
	application_surface_draw_enable(false); // Disable automatically drawing the application surface
	display_set_gui_size(640, 480); // Set the GUI size
	window_update_size();
	
	// EVENTS
	global.writerEvent = undefined; // The event number caused by the writer
	global.dialogueInteractedTo = noone; // The object the player has interacted with
	
	// FONT
	global.mainFontWidth = 16; // The main font width (8-Bit Operator JVE)
	global.mainFontHeight = 36; // The main font height (8-Bit Operator JVE)
	
	item_add(ITEM.MONSTER_CANDY);
	item_add(ITEM.BUTTERSCOTCH_PIE);
	
	// Debug mode
	#macro DEBUG true
}

function dialogue_simple(text, face = undefined, voice = snd_defaultvoice, font = fnt_main, battle = false) {
	with (obj_overworldui) {
		state = 0;
		dialogueText = text;
		dialogueFace = face;
		dialogueVoice = voice;
		dialogueFont = font;
		dialogueBattle = battle;
	}
}

function camera_is_on_top() {
	var cam = obj_camerahandler;
	return cam.posCenterY > cam.currTarget.y ? true : false;
}

function camera_set_target(target = noone) {
	obj_camerahandler.currTarget = target;
}

function camera_set_scale(_scaleX, _scaleY) {
	obj_camerahandler.camScaleX = _scaleX;
	obj_camerahandler.camScaleY = _scaleY;
}

function camera_set_pos(_posX, _posY) {
	obj_camerahandler.posX = _posX;
	obj_camerahandler.posY = _posY;
}

function camera_move_pos_to(posXTo, posYTo, tween = "linear", seconds = 1, relative = false, delay = 0) {
	obj_camerahandler.currTarget = noone;
	execute_tween(obj_camerahandler, "posCenterX", posXTo, "linear", seconds, relative, delay);
	execute_tween(obj_camerahandler, "posCenterY", posYTo, "linear", seconds, relative, delay);
}