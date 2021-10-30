/// @desc Initialize v2.0.0
/*
	Proverbs 3:5-8
	Trust in the Lord with all your heart and lean not on your own understanding;
	in all your ways submit to him, and he will make your paths straight.
	Do not be wise in your own eyes; fear the Lord and shun evil.
	This will bring health to your body and nourishment to your bones.
*/

// Make sure one isn't deactivated
instance_activate_object(o_SharedTweener);
// Destroy self if there ALREADY is a shared tweener out there
if (instance_exists(global.TGMS.SharedTweener))
{
	instance_destroy();
	exit;
}

// Clean previous shared tweener environment
if (global.TGMS.SharedTweener != noone)
{
	event_user(15);
}

// Mark self as the global shared tweener
global.TGMS.SharedTweener = id;

// Try to evade deactivation regions!
x = -100000;
y = -100000;

//-----------------------------------------------
// Declare Default Global System-Wide Settings
//-----------------------------------------------
global.TGMS.IsEnabled = true;         // System's active state boolean
global.TGMS.TimeScale = 1.0;          // Effects overall speed of how fast system plays tweens/delays
global.TGMS.MinDeltaFPS = 10;         // The lowest framerate before delta tweens will begin to lag behind (Ideally, keep between 10-15)
global.TGMS.UpdateInterval = 1.0;     // Sets how often (in steps) system will update (1 = default, 2 = half speed, 0.5 = double speed) DO NOT set as 0 or below!
global.TGMS.AutoCleanIterations = 10; // Limits, each step, number of tweens passively checked by memory manager (Default:10)
global.TGMS.EasyUseDelta = false;	  // Simple tweens use delta time?
global.TGMS.GroupScales[? 0] = 1.0;	  // Set default group 0 to use a default time scale of 1.0
global.TGMS.TweensIncludeDeactivated = false; // Whether or not to include tween's associated with deactivated targets when selecting tweens

//-------------------------------------------------
// Initiate Tween Index Supplier And Reference Map
//-------------------------------------------------
global.TGMS.TweenIndex = 1;

//---------------------------
// Create Default Tween
//---------------------------
global.TGMS.TweenDefault[TWEEN.ID] = TWEEN_DEFAULT;
global.TGMS.TweenDefault[TWEEN.TARGET] = noone;
global.TGMS.TweenDefault[TWEEN.EASE] = CurveLinear;
global.TGMS.TweenDefault[TWEEN.TIME] = 0;
global.TGMS.TweenDefault[TWEEN.DURATION] = 1;
global.TGMS.TweenDefault[TWEEN.PROPERTY_DATA_RAW] = -1;
global.TGMS.TweenDefault[TWEEN.STATE] = TWEEN_STATE.STOPPED;
global.TGMS.TweenDefault[TWEEN.SCALE] = 1;
global.TGMS.TweenDefault[TWEEN.DELTA] = false;
global.TGMS.TweenDefault[TWEEN.GROUP] = 0;
global.TGMS.TweenDefault[TWEEN.EVENTS] = -1;
global.TGMS.TweenDefault[TWEEN.DESTROY] = 1;
global.TGMS.TweenDefault[TWEEN.DIRECTION] = 1;
global.TGMS.TweenDefault[TWEEN.MODE] = TWEEN_MODE_ONCE;
global.TGMS.TweenDefault[TWEEN.PROPERTY_DATA] = 0;
global.TGMS.TweenDefault[TWEEN.DELAY] = 0;
global.TGMS.TweenDefault[TWEEN.DELAY_START] = 0;
global.TGMS.TweenDefault[TWEEN.AMOUNT] = 0;
global.TGMS.TweenDefault[TWEEN.CALLER] = noone;
global.TGMS.TweenDefault[TWEEN.REST] = 0;
global.TGMS.TweenDefault[TWEEN.CONTINUE_COUNT] = -1;
global.TGMS.TweenDefault[TWEEN.EASE_RAW] = 0;
	
	
//-------------------------------------------------
// Assign default tween as [1] in index map
//-------------------------------------------------
global.TGMS.TweenIndexMap[? 1] = global.TGMS.TweenDefault;
//---------------------------------------------------
// Assign [all] as shortcut for affecting all tweens
//---------------------------------------------------
global.TGMS.TweenIndexMap[? all] = {target: all};

// Global system-wide settings
isEnabled = global.TGMS.IsEnabled;                     // System's active state flag
timeScale = global.TGMS.TimeScale;                     // Global time scale of tweening engine
minDeltaFPS = global.TGMS.MinDeltaFPS;                 // Minimum frame rate before delta time will lag behind
updateInterval = global.TGMS.UpdateInterval;           // Step interval to update system (default = 1)
autoCleanIterations = global.TGMS.AutoCleanIterations; // Number of tweens to check each step for auto-cleaning

// System maintenance variables
tick = 0;									// System update timer
autoCleanIndex = 0;							// Used to track index when processing passive memory manager
maxDelta = 1/minDeltaFPS;					// Cache delta cap
deltaTime = 1/game_get_speed(gamespeed_fps);// Let's make delta time more practical to work with, shall we?
prevDeltaTime = deltaTime;					// Holds delta time from previous step
deltaRestored = false;						// Used to help maintain predictable delta timing
addDelta = 0.0;								// Amount to add to delta time if update interval not reached
flushDestroyed = false;						// Flag to indicate if destroyed tweens should be immediately cleared
tweensProcessNumber = 0;					// Number of tweens to be actively processed in update loop
delaysProcessNumber = 0;					// Number of delays to be actively processed in update loop
inUpdateLoop = false;						// Is tweening system actively processing tweens?

// Required data structures
tweens = ds_list_create();           // Stores automated step tweens
delayedTweens = ds_list_create();    // Stores tween delay data
pRoomTweens = ds_map_create();       // Associates persistent rooms with stored tween lists
pRoomDelays = ds_map_create();       // Associates persistent rooms with stored tween delay lists
eventCleaner = ds_priority_create(); // Used to clean callbacks from events
stateChanger = ds_queue_create();	 // Used to delay change of tween state when in the update loop

// These are used to clean up the system after Shared Tweener is already gone
global.TGMS.tweens = tweens;
global.TGMS.delayedTweens = delayedTweens;
global.TGMS.pRoomTweens = pRoomTweens;
global.TGMS.pRoomDelays = pRoomDelays;
global.TGMS.eventCleaner = eventCleaner;
global.TGMS.stateChanger = stateChanger;

// Set defaults for TWEEN USER properties
TWEEN_USER_GET = 0;
TWEEN_USER_VALUE = 0;
TWEEN_USER_DATA = undefined;
TWEEN_USER_TARGET = noone;


// Define Methods
function EaseSwap(_t)
{
	// SWAP DURATION //
	if (is_array(_t[TWEEN.DURATION_RAW]))
	{
		if (_t[TWEEN.DURATION] == _t[TWEEN.DURATION_RAW][0])
		{
			_t[@ TWEEN.DURATION] = _t[TWEEN.DURATION_RAW][1];
			// NOTE: This silently updates the internal time value... be careful!
			
			if (_t[TWEEN.MODE] <= TWEEN_MODE_PATROL)
			{
				_t[@ TWEEN.TIME] += _t[TWEEN.DURATION_RAW][1] - _t[TWEEN.DURATION_RAW][0];
			}
		}
		else
		{
			_t[@ TWEEN.DURATION] = _t[TWEEN.DURATION_RAW][0];
		}
	}
	
	// SWAP EASE ALGORITHM //
	if (is_array(_t[TWEEN.EASE_RAW]))
	{
		// Deal with method ease
		if (is_method(_t[TWEEN.EASE]))
		{
			if (is_method(_t[TWEEN.EASE_RAW][0]))
			{
				if (method_get_index(_t[TWEEN.EASE]) == method_get_index(_t[TWEEN.EASE_RAW][0]))
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][1];
				}
				else
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][0];
				}
			}
			else
			{
				if (method_get_index(_t[TWEEN.EASE]) == _t[TWEEN.EASE_RAW][0])
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][1];
				}
				else
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][0];
				}
			}
		}
		else // animation channel
		{
			if (is_method(_t[TWEEN.EASE_RAW][0]))
			{
				if (_t[TWEEN.EASE] == method_get_index(_t[TWEEN.EASE_RAW][0]))
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][1];
				}
				else
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][0];
				}
			}
			else
			{
				if (_t[TWEEN.EASE] == _t[TWEEN.EASE_RAW][0])
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][1];
				}
				else
				{
					_t[@ TWEEN.EASE] = _t[TWEEN.EASE_RAW][0];
				}
			}
		}
	}
}


function TweenHasReachedBounds(_t, _target, _time, _timeScaleDelta, _groupScales)
{
	if (_t[TWEEN.SCALE] != 0 && _groupScales[? _t[TWEEN.GROUP]] != 0 && (!_t[TWEEN.DELTA] || _timeScaleDelta != 0)) // Make sure time scale isn't "paused"
    {			
        // Update tween based on its play mode -- Could put overflow wait time in here????
        switch(_t[TWEEN.MODE])
        {
	    case TWEEN_MODE_ONCE:
			// Set tween's state as STOPPED
	        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;	 
			// Update tween's time to duration or 0
			_t[@ TWEEN.TIME] = _time > 0 ? _t[TWEEN.DURATION] : 0;
	        // Update property
			TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
	        // Execute FINISH event
	        TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0);
			// Destroy tween if temporary
	        if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }
	    break;
                        
		case TWEEN_MODE_BOUNCE:
		    if (_time > 0)
		    {	
				// UPDATE TIME
				_t[@ TWEEN.TIME] = _time;
								
				// REST
				if (_t[TWEEN.REST] > 0)
				{
					// Mark as resting
					_t[@ TWEEN.REST] = -_t[TWEEN.REST];
					// Update property
					TGMS_TweenProcess(_t, _t[TWEEN.DURATION], _t[TWEEN.PROPERTY_DATA], _target);
					// Execute Rest Event
					TGMS_ExecuteEvent(_t, TWEEN_EV_REST, 0);
				}
									
				// CONTINUE
				if (_time >= _t[TWEEN.DURATION] - _t[TWEEN.REST])
				{
					// Mark as no longer resting
					_t[@ TWEEN.REST] = -_t[TWEEN.REST];
					// Assign raw time to tween -- adjust for overflow
					_t[@ TWEEN.TIME] = 2*_t[TWEEN.DURATION] + _t[TWEEN.REST] - _time;	
					// NOTE: This can silently update tween's time
					EaseSwap(_t);
					// Reverse direction
				    _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];  
					// Reverse time scale
				    _t[@ TWEEN.SCALE] = -_t[TWEEN.SCALE];
				    // Update property
				    TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
					// Execute CONTINUE event
				    TGMS_ExecuteEvent(_t, TWEEN_EV_CONTINUE, 0);
				}
				else
				{	// Execute Resting Event
					TGMS_ExecuteEvent(_t, TWEEN_EV_RESTING, 0);	
				}
		    }
		    else // FINISH
		    {
				// Update tween's time
				_t[@ TWEEN.TIME] = 0;		
				// Reverse direction
			    _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION]; // NOTE: DO I NEED THIS???? I think so... but... maybe just set it to 1???
				// Reverse time scale
			    _t[@ TWEEN.SCALE] = -_t[TWEEN.SCALE];
				// Set tween state as STOPPED
		        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
				// Update property
		        TGMS_TweenProcess(_t, 0, _t[TWEEN.PROPERTY_DATA], _target);
		        // Execute FINISH event
				TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0);
				// Destroy tween if temporary
		        if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }    
		    }
		break;
                        
	    case TWEEN_MODE_PATROL:
						
			// FINISH
			if (_t[TWEEN.CONTINUE_COUNT] == 0) 
			{
				// Update tween's time
				_t[@ TWEEN.TIME] = _t[TWEEN.DURATION] * (_time > 0);		
				// Reverse direction
				_t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];  
				// Reverse time scale
				_t[@ TWEEN.SCALE] = -_t[TWEEN.SCALE];
				// Set tween state as STOPPED
				_t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
				// Update property
				TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute FINISH event
				TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0);
				// Destroy tween if temporary
				if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }   
								
				break;
			}
						
			// UPDATE TIME
			_t[@ TWEEN.TIME] = _time;
							
			if (is_real(_t[TWEEN.REST]))
			{
				_t[@ TWEEN.REST] = array_create(2, _t[TWEEN.REST]);	
			}
							
			var _rest = _t[TWEEN.REST];
			var _restIndex = _time > 0;
							
			// REST
			if (_rest[_restIndex] > 0)
			{
				// Mark as resting by setting to negative value
				_rest[@ _restIndex] = -_rest[_restIndex];
				// Update property
				TGMS_TweenProcess(_t, _time <= 0 ? 0 : _t[TWEEN.DURATION], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute Rest Event
				TGMS_ExecuteEvent(_t, TWEEN_EV_REST, 0);
			}
								
			// CONTINUE
			if (_time >= _t[TWEEN.DURATION] - _rest[_restIndex] || _time <= _rest[_restIndex])
			{
				// Decrement continue counter
				_t[@ TWEEN.CONTINUE_COUNT] = _t[TWEEN.CONTINUE_COUNT] - 1;
				// Mark as no longer resting
				_rest[@ _restIndex] = -_rest[_restIndex];
				// Assign raw time to tween -- adjust for overflow
				_t[@ TWEEN.TIME] = _time > 0 ? 2*_t[TWEEN.DURATION] + _rest[_restIndex] - _time : abs(_time)-_rest[_restIndex];
				// NOTE: This can silently update tween's time
				EaseSwap(_t);
				// Reverse direction
				_t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];  
				// Reverse time scale
				_t[@ TWEEN.SCALE] = -_t[TWEEN.SCALE];
				// Update property
				TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute CONTINUE event
				TGMS_ExecuteEvent(_t, TWEEN_EV_CONTINUE, 0);
			}
			else
			{	// Execute Resting Event
				TGMS_ExecuteEvent(_t, TWEEN_EV_RESTING, 0);
			}
	    break;
                        
	    case TWEEN_MODE_LOOP:
						
			// FINISH
			if (_t[TWEEN.CONTINUE_COUNT] == 0) 
			{
				// Update tween's time
				_t[@ TWEEN.TIME] = _t[TWEEN.DURATION];		 
				// Set tween state as STOPPED
				_t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
				// Update property
				TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute FINISH event
				TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0);
				// Destroy tween if temporary
				if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }   
				// Break out of mode's switch case
				break;
			}
						
			// UPDATE TIME
			_t[@ TWEEN.TIME] = _time;
						
			// REST
			if (_t[TWEEN.REST] > 0)
			{
				// Mark as resting
				_t[@ TWEEN.REST] = -_t[TWEEN.REST];
				// Update property
				TGMS_TweenProcess(_t, _time <= 0 ? 0 : _t[TWEEN.DURATION], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute Rest Event
				TGMS_ExecuteEvent(_t, TWEEN_EV_REST, 0);
			}
								
			// Check for continue
			if (_time >= _t[TWEEN.DURATION] - _t[TWEEN.REST] || _time <= _t[TWEEN.REST])
			{
				_t[@ TWEEN.CONTINUE_COUNT] = _t[TWEEN.CONTINUE_COUNT] - 1;
				// Mark as no longer resting
				_t[@ TWEEN.REST] = -_t[TWEEN.REST];
				// Assign raw time to tween
				_t[@ TWEEN.TIME] = _time > 0 ? _time-_t[TWEEN.DURATION]-_t[TWEEN.REST] : _time+_t[TWEEN.DURATION]+_t[TWEEN.REST];
				// Swap eases or duration -- can silenty change tween's time
				EaseSwap(_t);
		        // Update property
		        TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
		        // Execute CONTINUE event
		        TGMS_ExecuteEvent(_t, TWEEN_EV_CONTINUE, 0);
			}
			else // Keep resting
			{
				TGMS_ExecuteEvent(_t, TWEEN_EV_RESTING, 0);
			}
		break;
                        
	    case TWEEN_MODE_REPEAT:
							
			// FINISH
			if (_t[TWEEN.CONTINUE_COUNT] == 0) 
			{
				// Update tween's time
				_t[@ TWEEN.TIME] = _t[TWEEN.DURATION];		 
				// Set tween state as STOPPED
				_t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
				// Update property
				TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute FINISH event
				TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0);
				// Destroy tween if temporary
				if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }   
				// Break out of switch case
				break;
			}
							
			// UPDATE TIME
			_t[@ TWEEN.TIME] = _time;
							
			// REST
			if (_t[TWEEN.REST] > 0)
			{
				// Mark as resting
				_t[@ TWEEN.REST] = -_t[TWEEN.REST];
				// Update property
				TGMS_TweenProcess(_t, _time <= 0 ? 0 : _t[TWEEN.DURATION], _t[TWEEN.PROPERTY_DATA], _target);
				// Execute Rest Event
				TGMS_ExecuteEvent(_t, TWEEN_EV_REST, 0);
			}
								
			// CONTINUE
			if (_time >= _t[TWEEN.DURATION] - _t[TWEEN.REST] || _time <= _t[TWEEN.REST])
			{
				// Decrement countinue counter
				_t[@ TWEEN.CONTINUE_COUNT] = _t[TWEEN.CONTINUE_COUNT] - 1;
				// Mark as no longer resting
				_t[@ TWEEN.REST] = -_t[TWEEN.REST];
				// Update raw time with epsilon compensation
				_t[@ TWEEN.TIME] = _time > 0 ? _time-_t[TWEEN.DURATION]-_t[TWEEN.REST] : _time+_t[TWEEN.DURATION]+_t[TWEEN.REST];
				// NOTE: This can silently update tween's time
				EaseSwap(_t);
				// Update new relative start position
				var _data = _t[TWEEN.PROPERTY_DATA];
				var i = 2;
				repeat(array_length(_data) div 4)
				{
					_data[@ i] += _time > 0 ? _data[i+1] : -_data[i+1];
					i += 4;
				}
		        // Update property
		        TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], _target);
		        // Execute CONTINUE event
				TGMS_ExecuteEvent(_t, TWEEN_EV_CONTINUE, 0);
			}
			else
			{
				TGMS_ExecuteEvent(_t, TWEEN_EV_RESTING, 0);
			}
	    break;
                        
	    default:
	        show_error("Invalid Tween Mode! --> Forcing TWEEN_MODE_ONCE", false);
	        _t[@ TWEEN.MODE] = TWEEN_MODE_ONCE;
        }
    }
}


