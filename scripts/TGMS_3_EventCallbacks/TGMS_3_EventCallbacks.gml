/*
	Required function(s):
		TweenAddCallback

	Is is safe to delete:
		TweenAddCallbackUser
		TweenCallbackEnable
		TweenCallbackInvalidate
		TweenCallbackIsEnabled
		TweenCallbackIsValid
		TweenEventClear
		TweenEventEnable
		TweenEventIsEnabled
*/

#region Doc
/// @func TweenAddCallback(tween, event, target, script, *arg0, ...);
/// @desc Adds script to be called on tween event
/*
	tween		tween id
	event		tween event macro (TWEEN_EV_*)
	target		target instance id -- callback will use this environment to call function
	script		script to call on tween event
	[arg0,...]	(optional) arguments to pass to script

	return: callback id
   
	[INFO]
	Sets a script to be called on specified tween event.
	Multiple callbacks can be added to the same event.
        
	"event" can take any of the following TWEEN_EV_* macros:
	TWEEN_EV_PLAY
	TWEEN_EV_FINISH
	TWEEN_EV_CONTINUE
	TWEEN_EV_STOP
	TWEEN_EV_PAUSE
	TWEEN_EV_RESUME
	TWEEN_EV_REVERSE 
		
	TWEEN_EV_FINISH_DELAY
	TWEEN_EV_STOP_DELAY
	TWEEN_EV_PAUSE_DELAY
	TWEEN_EV_RESUME_DELAY   
*/
#endregion
function TweenAddCallback(tweenID, event, target, script) 
{
	var _t = TGMS_FetchTween(tweenID);
	if (is_undefined(_t)) { return undefined; }

	var _events = _t[TWEEN.EVENTS];
	var _cb;
	
	// Check for "event" string
	if (is_string(event))
	{
		event = string_char_at(event, 1) == "@" ? global.TGMS_ArgumentLabels[? event] : global.TGMS_ArgumentLabels[? "@"+event];
	}

	// Create and assign events map if it doesn't exist
	if (_events == -1)
	{
	    _events = ds_map_create();
	    _t[@ TWEEN.EVENTS] = _events;
	}

	var _index = argument_count;
	repeat(_index-3)
	{
	    --_index;
	    _cb[_index] = argument[_index];
	}

	// Assign tween id to callback
	_cb[TWEEN_CB.TWEEN] = tweenID;
	// Set default state as active
	_cb[TWEEN_CB.ENABLED] = true;
	// Assign script to callback
	_cb[TWEEN_CB.SCRIPT] = script; 
	// Assign target to callback
	_cb[TWEEN_CB.TARGET] = is_real(target) ? target : weak_ref_create(target);

	// IF event type exists...
	if (ds_map_exists(_events, event))
	{
	    // Cache event
	    var _event = _events[? event];
	    // Add event to events map
	    ds_list_add(_event, _cb);
    
	    // Do some event callback cleanup if size starts to get larger than expected
	    if (ds_list_size(_event) % 5 == 0)
	    {   
	        ds_priority_add(SharedTweener().eventCleaner, _event, _event);
	    }
	}
	else
	{
	    // Create event list
	    var _event = ds_list_create();
	    // Add STATE and CALLBACK to event
	    ds_list_add(_event, true, _cb);
	    // Add event to events map -- auto-destroyed when map is destroyed
		ds_map_add_list(_events, event, _event); //_events[? event] = _event;
	}
	
	// Return callback array
	return _cb;
}

/// @func TweenAddCallbackUser(tween, event, target, user_event) : callback id
/// @desc Sets a user event to be called on tween event
function TweenAddCallbackUser(_tweenID, _event, _target, _user) 
{
	// tween		tween id
	// event		tween event macro (TWEEN_EV_*)
	// target		instance to call user event
	// user			user event to be called (0-15)
	/*        
	    INFO:
	        Sets a user event (0-15) to be called on specified tween event.
	        Multiple callbacks can be added to the same event.
        
	        "event" can take any of the following macros:
	        TWEEN_EV_PLAY
	        TWEEN_EV_FINISH
	        TWEEN_EV_CONTINUE
	        TWEEN_EV_STOP
	        TWEEN_EV_PAUSE
	        TWEEN_EV_RESUME
	        TWEEN_EV_REVERSE    

			TWEEN_EV_FINISH_DELAY
			TWEEN_EV_STOP_DELAY
			TWEEN_EV_PAUSE_DELAY
			TWEEN_EV_RESUME_DELAY  
	*/

	TweenAddCallback(_tweenID, _event, _target, TGMS_EventUser, _user);
}

/// @desc Enables/disables specified callbacks
function TweenCallbackEnable(callback, enable)
{
	if (is_array(callback))
	{
	    callback[@ TWEEN_CB.ENABLED] = enable;
	}
}

/// @desc Removes callback from its associated tween event
function TweenCallbackInvalidate(callback) 
{
	/*      
	    Example:
	        // Create tween and add callback to finish event
	        tween = TweenCreate(id);
	        cb = TweenEventAddCallback(tween, TWEEN_EV_FINISH, id, ShowMessage, "Finished!");
        
	        // Invalidate callback -- effectively removes it from tween event
	        TweenInvalidate(cb);
	*/

	if (is_array(callback))
	{
	    // Set target as noone -- used for system cleaning
	    callback[@ TWEEN_CB.TARGET] = undefined; // Note: Why is this undefind and not 'noone'?
	}
}

/// @desc Checks if callback is enabled
function TweenCallbackIsEnabled(cb) 
{
	return is_array(callback) ? (callback[TWEEN_CB.ENABLED] && callback[TWEEN_CB.TARGET] != undefined) : false;
}

/// @desc Checks if callback id is valid
function TweenCallbackIsValid(callback) 
{
	/// return: bool
	/*      
	    Example:
	        if (TweenCallbackIsValid(callback))
	        {
	            TweenCallbackInvalidate(callback);
	        }
	*/
	
	return is_array(callback) ? TweenExists(callback[TWEEN_CB.TWEEN]) : false;
}

/// @desc Invalidates all callbacks associated with tween event
function TweenEventClear(_t, event)
{
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)

	if (event == undefined)
	{
		show_error("Invalid argument count for TweenEventClear(tween, event)", false);	
	}

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    var _events = _t[TWEEN.EVENTS];
    
	    if (_events != -1)
	    {    
	        if (ds_map_exists(_events, event))
	        {
	            var _event = _events[? event]; 
	            var _index = 0;
            
	            repeat(ds_list_size(_event)-1)
	            {
	                // Invalidate callback
					_event[| ++_index][@ TWEEN_CB.TWEEN] = TWEEN_NULL;
	            }
	        }
	    }
	}
	else 
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenEventClear, event);
	}
}

/// @desc Enables/disables specified tween event
function TweenEventEnable(_t, event, enable) 
{
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param enable		enable event?

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    var _events = _t[TWEEN.EVENTS];
    
	    // Create and assign events map if it doesn't exist
	    if (_events == -1)
	    {
	        _events = ds_map_create();
	        _t[@ TWEEN.EVENTS] = _events;
	    }
    
	    if (!ds_map_exists(_events, event))
	    {
	        // Create event list
	        var _event = ds_list_create();
	        // Add event to events map
	        _events[? event] = _event;
	    }
    
	    // Set tween event state
	    var _event = _events[? event];
	    _event[| 0] = enable;
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenEventEnable, event, enable);
	}
}

/// @desc Checks if tween event is enabled
function TweenEventIsEnabled(_t, event) 
{
	/// @param tween	tween id
	/// @param event	tween event macro (TWEEN_EV_*)
	/// return: bool

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	// Get events map from tween
	var _events = _t[TWEEN.EVENTS];
	// Return true if events don't exist
	if (_events == -1) { return true; }
	// Return true if event type doesn't exist
	if (!ds_map_exists(_events, event)) { return true; }
	// Return event's [enabled] state boolean
	return ds_list_find_value(_events[? event], 0);
}



