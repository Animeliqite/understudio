

// This is immediately called at the bottom of this script
function TGMS_Begin()
{
	if (!variable_global_exists("TGMS")) 
	{ 
		global.TGMS = {}; 
	}
	else
	{
		return;
	}
	
	global.TGMS.SharedTweener = noone;
	global.TGMS.tween_self = undefined;
	global.TGMS.TweenIndexMap = ds_map_create();
	global.TGMS.GroupScales = ds_map_create();
	global.TGMS.PropertySetters = ds_map_create();
	global.TGMS.PropertyGetters = ds_map_create();
	global.TGMS.PropertyNormals = ds_map_create();
	global.TGMS.MagnitudeCurves = ds_map_create();
	

	//-------------------------------
	// MACROS
	//-------------------------------
	#macro TGMS_REMOVE_CALLBACK "TGMS_RCB"
	#macro TGMS_OPTIMISE_USER 0
	#macro TWEEN_DEFAULT 1
	//#macro TWEEN_SELF global.TGMS.tween_self
	#macro TWEEN_NULL undefined
	
	#macro TWEEN_SELF (is_undefined(global.TGMS.tween_self) ? array_get(argument[3], TWEEN.ID) : global.TGMS.tween_self)

	//---------------------------------------
	// DEFINE SYSTEM MACROS
	//---------------------------------------
	// TWEEN PLAY MODES
	#macro TWEEN_MODE_ONCE 0   // Tween plays from start to finish, once
	#macro TWEEN_MODE_BOUNCE 1 // Tween plays from start to finish before playing back to start
	#macro TWEEN_MODE_PATROL 2 // Tween plays back and forth between start and finish -- continues until manually stopped
	#macro TWEEN_MODE_LOOP 3   // Tween loops from start to finish -- continues until manually stopped
	#macro TWEEN_MODE_REPEAT 4 // Tween uses finish position as a new relative starting position -- continues until manually stopped

	// TWEEN EVENT TYPES
	#macro TWEEN_EV_PLAY 0			// When tween starts to play
	#macro TWEEN_EV_FINISH 1		// When tween finishes playing
	#macro TWEEN_EV_STOP 2			// When tween is stopped manually
	#macro TWEEN_EV_PAUSE 3			// When tween is paused manually
	#macro TWEEN_EV_RESUME 4		// When tween is resumed manually
	#macro TWEEN_EV_CONTINUE 5		// When tween bounces, patrols, loops, or repeats
	#macro TWEEN_EV_REVERSE 6		// When tween is reversed manually
	#macro TWEEN_EV_STOP_DELAY 7	// When tween is stopped while it is delayed
	#macro TWEEN_EV_PAUSE_DELAY 8	// When tween is paushed while delayed
	#macro TWEEN_EV_RESUME_DELAY 9	// When tween is resumed while delayed
	#macro TWEEN_EV_FINISH_DELAY 10	// When tween's delay finishes -- Called just before TWEEN_EV_PLAY
	#macro TWEEN_EV_REST 11
	#macro TWEEN_EV_RESTING 12
	#macro TWEEN_EV_COUNT 13

	// TWEEN USER PROPERTIES
	#macro TWEEN_USER_VALUE global.TGMS.user_value	 // Tweened value passed to user event
	#macro TWEEN_USER_TARGET global.TGMS.user_target // Tweened target passed to user event
	#macro TWEEN_USER_GET global.TGMS.tween_user_get // Used to allow 'getters' for user event properties
	#macro TWEEN_USER_DATA global.TGMS.user_data	 // Optional data passed to user event properties

	//-------------------------------
	// Declare Enums
	//-------------------------------
	// TWEEN DATA
	enum TWEEN
	{
		STATE, // The first index needs to be something not used by shorthand codes!
		DURATION,
		DURATION_RAW,
		DELTA,
		SCALE,
		TIME,
		TARGET,
		EASE,
		PROPERTY_DATA,
		PROPERTY_DATA_RAW,
		GROUP,
		DIRECTION,
		EVENTS,
		DESTROY,
		MODE,
		DELAY,
		DELAY_START,
		ID,
		AMOUNT,
		CALLER,
		REST,
		CONTINUE_COUNT,
		EASE_RAW,
		DATA_SIZE,
	
		CHANGE,
		START,
		DESTINATION,
		PROPERTY,
		RAW_START,
		RAW_DESTINATION,
	}

	// TWEEN STATES
	enum TWEEN_STATE{DESTROYED=-4,STOPPED=-10,PAUSED=-11,DELAYED=-12};
	// TWEEN CALLBACK DATA
	enum TWEEN_CB{TWEEN,ENABLED,TARGET,SCRIPT,ARG};

	// INITIALISE EVENT MAPS FOR TweenIs*() SCRIPTS
	global.TGMS.EventMaps = array_create(TWEEN_EV_COUNT);
	var i = -1;
	repeat(TWEEN_EV_COUNT)
	{
		global.TGMS.EventMaps[++i] = ds_map_create();
	}

	//-----------------------------
	// Tween Data Label Indexing --> Sounds fancier than it really is!
	//-----------------------------
	global.TGMS.TweenDataLabelMap = ds_map_create();

	global.TGMS.TweenDataLabelMap[? "target"] = TWEEN.TARGET;
	global.TGMS.TweenDataLabelMap[? "?"] = TWEEN.TARGET;
	global.TGMS.TweenDataLabelMap[? "time"] = TWEEN.TIME;
	global.TGMS.TweenDataLabelMap[? "="] = TWEEN.TIME;
	global.TGMS.TweenDataLabelMap[? "scale"] = TWEEN.SCALE;
	global.TGMS.TweenDataLabelMap[? "timescale"] = TWEEN.SCALE;
	global.TGMS.TweenDataLabelMap[? "*"] = TWEEN.SCALE;
	global.TGMS.TweenDataLabelMap[? "amount"] = TWEEN.AMOUNT;
	global.TGMS.TweenDataLabelMap[? "timeamount"] = TWEEN.AMOUNT;
	global.TGMS.TweenDataLabelMap[? "%"] = TWEEN.AMOUNT;
	global.TGMS.TweenDataLabelMap[? "ease"] = TWEEN.EASE;
	global.TGMS.TweenDataLabelMap[? "~"] = TWEEN.EASE;
	global.TGMS.TweenDataLabelMap[? "start"] = TWEEN.START;
	global.TGMS.TweenDataLabelMap[? "destination"] = TWEEN.DESTINATION;
	global.TGMS.TweenDataLabelMap[? "dest"] = TWEEN.DESTINATION;
	global.TGMS.TweenDataLabelMap[? "rawstart"] = TWEEN.RAW_START;
	global.TGMS.TweenDataLabelMap[? "rawdestination"] = TWEEN.RAW_DESTINATION;
	global.TGMS.TweenDataLabelMap[? "rawdest"] = TWEEN.RAW_DESTINATION;
	global.TGMS.TweenDataLabelMap[? "duration"] = TWEEN.DURATION;
	global.TGMS.TweenDataLabelMap[? "$"] = TWEEN.DURATION;
	global.TGMS.TweenDataLabelMap[? "dur"] = TWEEN.DURATION;
	global.TGMS.TweenDataLabelMap[? "rest"] = TWEEN.REST;
	global.TGMS.TweenDataLabelMap[? "|"] = TWEEN.REST;
	global.TGMS.TweenDataLabelMap[? "delay"] = TWEEN.DELAY;
	global.TGMS.TweenDataLabelMap[? "delaystart"] = TWEEN.DELAY_START;
	global.TGMS.TweenDataLabelMap[? "group"] = TWEEN.GROUP;
	global.TGMS.TweenDataLabelMap[? "&"] = TWEEN.GROUP;
	global.TGMS.TweenDataLabelMap[? "state"] = TWEEN.STATE;
	global.TGMS.TweenDataLabelMap[? "mode"] = TWEEN.MODE;
	global.TGMS.TweenDataLabelMap[? "#"] = TWEEN.MODE;
	global.TGMS.TweenDataLabelMap[? "delta"] = TWEEN.DELTA;
	global.TGMS.TweenDataLabelMap[? "^"] = TWEEN.DELTA;
	global.TGMS.TweenDataLabelMap[? "property"] = TWEEN.PROPERTY;
	global.TGMS.TweenDataLabelMap[? "properties"] = TWEEN.PROPERTY;
	global.TGMS.TweenDataLabelMap[? "prop"] = TWEEN.PROPERTY;
	global.TGMS.TweenDataLabelMap[? "continuecount"] = TWEEN.CONTINUE_COUNT;
	global.TGMS.TweenDataLabelMap[? "count"] = TWEEN.CONTINUE_COUNT;
	global.TGMS.TweenDataLabelMap[? "cc"] = TWEEN.CONTINUE_COUNT;
	global.TGMS.TweenDataLabelMap[? TWEEN.TARGET] = TWEEN.TARGET;
	global.TGMS.TweenDataLabelMap[? TWEEN.PROPERTY_DATA_RAW] = TWEEN.PROPERTY_DATA_RAW;
	global.TGMS.TweenDataLabelMap[? TWEEN.TIME] = TWEEN.TIME;
	global.TGMS.TweenDataLabelMap[? TWEEN.SCALE] = TWEEN.SCALE;
	global.TGMS.TweenDataLabelMap[? TWEEN.AMOUNT] = TWEEN.AMOUNT;
	global.TGMS.TweenDataLabelMap[? TWEEN.EASE] = TWEEN.EASE;
	global.TGMS.TweenDataLabelMap[? TWEEN.START] = TWEEN.START;
	global.TGMS.TweenDataLabelMap[? TWEEN.DESTINATION] = TWEEN.DESTINATION;
	global.TGMS.TweenDataLabelMap[? TWEEN.DURATION] = TWEEN.DURATION;
	global.TGMS.TweenDataLabelMap[? TWEEN.DELAY] = TWEEN.DELAY;
	global.TGMS.TweenDataLabelMap[? TWEEN.DELAY_START] = TWEEN.DELAY_START;
	global.TGMS.TweenDataLabelMap[? TWEEN.GROUP] = TWEEN.GROUP;
	global.TGMS.TweenDataLabelMap[? TWEEN.STATE] = TWEEN.STATE;
	global.TGMS.TweenDataLabelMap[? TWEEN.MODE] = TWEEN.MODE;
	global.TGMS.TweenDataLabelMap[? TWEEN.DELTA] = TWEEN.DELTA;

	//------------------------------------------------------------------------------------------------
	// Set supported labels for tween "tags".
	// There are multiple values for each property, allowing for alternative and shorthand labels.
	// Modify or add your own labels as desired!!!
	//------------------------------------------------------------------------------------------------
	global.TGMS.ArgumentLabels = ds_map_create();
	var _ = global.TGMS.ArgumentLabels;

	// TWEEN CHAIN
	_[? ">>"] = 0;
	// Continue Count
	_[? ">"] = TWEEN.CONTINUE_COUNT;
	_[? "-continuecount"] = TWEEN.CONTINUE_COUNT;
	_[? "-count"] = TWEEN.CONTINUE_COUNT;
	_[? "-cc"] = TWEEN.CONTINUE_COUNT;
	// TARGET
	_[? "-target"] = TWEEN.TARGET;
	_[? "?"] = TWEEN.TARGET;
	// EASE
	_[? "-ease"] = TWEEN.EASE;
	_[? "~"] = TWEEN.EASE;
	// MODE
	_[? "-mode"] = TWEEN.MODE;
	_[? "#"] = TWEEN.MODE;
	// DURATION
	_[? "-duration"] = TWEEN.DURATION;
	_[? "-dur"] = TWEEN.DURATION;
	_[? "$"] = TWEEN.DURATION;
	// DELTA (Use Seconds?)
	_[? "-delta"] = TWEEN.DELTA;
	_[? "^"] = TWEEN.DELTA;
	// DELAY
	_[? "-delay"] = TWEEN.DELAY;
	_[? "+"] = TWEEN.DELAY;
	// REST
	_[? "-rest"] = TWEEN.REST;
	_[? "|"] = TWEEN.REST;
	// GROUP
	_[? "-group"] = TWEEN.GROUP;
	_[? "&"] = TWEEN.GROUP;
	// TIME
	_[? "-time"] = TWEEN.TIME;
	_[? "="] = TWEEN.TIME;
	// TIME AMOUNT / POSITION -- relative value between 0 and 1
	_[? "-timeamount"] = TWEEN.AMOUNT;
	_[? "-amount"] = TWEEN.AMOUNT;
	_[? "%"] = TWEEN.AMOUNT;
	// TIME SCALE
	_[? "-timescale"] = TWEEN.SCALE;
	_[? "-scale"] = TWEEN.SCALE;
	_[? "*"] = TWEEN.SCALE;
	// AUTO-DESTROY
	_[? "-destroy"] = TWEEN.DESTROY;
	_[? "!"] = TWEEN.DESTROY;

	// Add argument labels to label maps
	var _key = ds_map_find_first(_);
	repeat(ds_map_size(_))
	{
		global.TGMS.TweenDataLabelMap[? _key] = _[? _key];
		_key = ds_map_find_next(_, _key);
	}

	// THIS IS THE SAME MAP AS ABOVE... THIS IS NOT CLEAR AT A GLANCE!!!!
	// CALLBACK EVENTS
	_[? "@"] = TWEEN_EV_FINISH;
	_[? "@finish"] = TWEEN_EV_FINISH;
	_[? "@finished"] = TWEEN_EV_FINISH;
	_[? "@continue"] = TWEEN_EV_CONTINUE;
	_[? "@continued"] = TWEEN_EV_CONTINUE;
	_[? "@pause"] = TWEEN_EV_PAUSE;
	_[? "@paused"] = TWEEN_EV_PAUSE;
	_[? "@play"] = TWEEN_EV_PLAY;
	_[? "@played"] = TWEEN_EV_PLAY;
	_[? "@resume"] = TWEEN_EV_RESUME;
	_[? "@resumed"] = TWEEN_EV_RESUME;
	_[? "@stop"] = TWEEN_EV_STOP;
	_[? "@stopped"] = TWEEN_EV_STOP;
	_[? "@reverse"] = TWEEN_EV_REVERSE;
	_[? "@reversed"] = TWEEN_EV_REVERSE;
	_[? "@rest"] = TWEEN_EV_REST;
	_[? "@rested"] = TWEEN_EV_REST;
	_[? "@resting"] = TWEEN_EV_RESTING;
	_[? "@finishdelay"] = TWEEN_EV_FINISH_DELAY;
	_[? "@delayfinish"] = TWEEN_EV_FINISH_DELAY;
	_[? "@finisheddelay"] = TWEEN_EV_FINISH_DELAY;
	_[? "@delayfinished"] = TWEEN_EV_FINISH_DELAY;
	_[? "@pausedelay"] = TWEEN_EV_PAUSE_DELAY;
	_[? "@delaypause"] = TWEEN_EV_PAUSE_DELAY;
	_[? "@pauseddelay"] = TWEEN_EV_PAUSE_DELAY;
	_[? "@delaypaused"] = TWEEN_EV_PAUSE_DELAY;
	_[? "@resumedelay"] = TWEEN_EV_RESUME_DELAY;
	_[? "@delayresume"] = TWEEN_EV_RESUME_DELAY;
	_[? "@resumeddelay"] = TWEEN_EV_RESUME_DELAY;
	_[? "@delayresumed"] = TWEEN_EV_RESUME_DELAY;
	_[? "@stopdelay"] = TWEEN_EV_STOP_DELAY;
	_[? "@delaystop"] = TWEEN_EV_STOP_DELAY;
	_[? "@stoppeddelay"] = TWEEN_EV_STOP_DELAY;
	_[? "@delaystopped"] = TWEEN_EV_STOP_DELAY;
	
	_[? "@update"] = -1; // TODO: This is reserved for possible "@update" event

	// Create a shorthand lookup table for shorthand symbols
	_ = array_create(128);
	_[33]  = TWEEN.DESTROY; 
	_[35]  = TWEEN.MODE; 
	_[36]  = TWEEN.DURATION; 
	_[37]  = TWEEN.AMOUNT;
	_[38]  = TWEEN.GROUP;
	_[42]  = TWEEN.SCALE;
	_[43]  = TWEEN.DELAY;
	_[59]  = TWEEN.REST;
	_[61]  = TWEEN.TIME;
	_[62]  = TWEEN.CONTINUE_COUNT;
	_[94]  = TWEEN.DELTA; 
	_[124] = TWEEN.REST;
	_[126] = TWEEN.EASE;
	global.TGMS.ShorthandTable = _;

	//====================//
	// MODE "SHORT CODES" //
	//====================//
	global.TGMS.ShortCodesMode = ds_map_create();
	_= global.TGMS.ShortCodesMode;

	// MODE "SHORT CODES"
	_[? "#0"] = TWEEN_MODE_ONCE;		_[? "0"] = TWEEN_MODE_ONCE;
	_[? "#o"] = TWEEN_MODE_ONCE;		_[? "o"] = TWEEN_MODE_ONCE;
	_[? "#once"] = TWEEN_MODE_ONCE;		_[? "once"] = TWEEN_MODE_ONCE;
	
	_[? "#1"] = TWEEN_MODE_BOUNCE;		_[? "1"] = TWEEN_MODE_BOUNCE;
	_[? "#b"] = TWEEN_MODE_BOUNCE;		_[? "b"] = TWEEN_MODE_BOUNCE;
	_[? "#bounce"] = TWEEN_MODE_BOUNCE;	_[? "bounce"] = TWEEN_MODE_BOUNCE;
	
	_[? "#2"] = TWEEN_MODE_PATROL;		_[? "2"] = TWEEN_MODE_PATROL;
	_[? "#p"] = TWEEN_MODE_PATROL;		_[? "p"] = TWEEN_MODE_PATROL;
	_[? "#patrol"] = TWEEN_MODE_PATROL; _[? "patrol"] = TWEEN_MODE_PATROL;
	
	_[? "#3"] = TWEEN_MODE_LOOP;		_[? "3"] = TWEEN_MODE_LOOP;
	_[? "#l"] = TWEEN_MODE_LOOP;		_[? "l"] = TWEEN_MODE_LOOP;
	_[? "#loop"] = TWEEN_MODE_LOOP;		_[? "loop"] = TWEEN_MODE_LOOP;
	
	_[? "#4"] = TWEEN_MODE_REPEAT;		_[? "4"] = TWEEN_MODE_REPEAT;
	_[? "#r"] = TWEEN_MODE_REPEAT;		_[? "r"] = TWEEN_MODE_REPEAT;
	_[? "#repeat"] = TWEEN_MODE_REPEAT;	_[? "repeat"] = TWEEN_MODE_REPEAT;
}

// Let's call the Begin function right away
TGMS_Begin();





