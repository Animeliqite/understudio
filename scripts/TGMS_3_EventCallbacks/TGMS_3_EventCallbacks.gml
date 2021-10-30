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


function TweenAddCallback(tweenID, event, target, func) 
{	/// @func TweenAddCallback(tween, event, target, func|user, *arg0, *arg1);
	/// @desc Adds function or user event to be called on specified tween event
	/*
		tween		tween id
		event		tween event macro (TWEEN_EV_*)
		target		target instance id -- callback will use this environment to call function
		func		function or user event to call on specified tween event
		*arg0...*	optional arguments to pass to function call
	
		return: callback id
	   
		[INFO]
		Sets a function or user event to be called on specified tween event.
		Multiple callbacks can be added to the same event.
	        
		"event" can take any of the following TWEEN_EV_* macros or strings:
		TWEEN_EV_PLAY			"play"				"played"
		TWEEN_EV_FINISH			"finish"			"finished"
		TWEEN_EV_CONTINUE		"continue"			"continued"
		TWEEN_EV_STOP			"stop"				"stopped"
		TWEEN_EV_PAUSE			"pause"				"paused"
		TWEEN_EV_RESUME			"resume"			"resumed"
		TWEEN_EV_REVERSE		"reverse"			"reversed"
													
		TWEEN_EV_FINISH_DELAY	"finish_delay"		"finished_delay"
		TWEEN_EV_STOP_DELAY		"stop_delay"		"stopped_delay"
		TWEEN_EV_PAUSE_DELAY	"pause_delay"		"paused_delay"
		TWEEN_EV_RESUME_DELAY   "resume_delay"		"resumed_delay"
	*/
	
	var _t = TGMS_FetchTween(tweenID);
	if (is_undefined(_t)) { return undefined; }

	var _events = _t[TWEEN.EVENTS];
	var _cb;
	
	// Check for "event" string
	static str_AT = "@";
	if (is_string(event)) 
	{ 
		event = string_char_at(event, 1) == str_AT ? global.TGMS.ArgumentLabels[? event] : global.TGMS.ArgumentLabels[? str_AT+event];
	}

	// Create and assign events map if it doesn't exist
	if (_events == -1) 
	{
	    _events = ds_map_create();
	    _t[@ TWEEN.EVENTS] = _events;
	}

	// Handle user event indexes (0-15)
	if (is_real(func) && func <= 15)
	{
		_cb[4] = func; // Add the user event argument to callback
		func = event_user; // Assign event_user function to func
	}
	else
	{
		// Add function arguments
		var _index = argument_count;
		repeat(_index-3) 
		{
		    --_index;
		    _cb[_index] = argument[_index];
		}
	}

	// Assign tween id to callback
	_cb[TWEEN_CB.TWEEN] = tweenID;
	// Set default state as active
	_cb[TWEEN_CB.ENABLED] = true;
	// Assign function to callback
	_cb[TWEEN_CB.SCRIPT] = func; 
	// Assign target to callback
	_cb[TWEEN_CB.TARGET] = is_real(target) ? target : weak_ref_create(target);

	if (ds_map_exists(_events, event))
	{ // IF event type exists...
	    // Cache event
	    var _event = _events[? event];
	    // Add event to events map
	    ds_list_add(_event, _cb);
    
	    // Do some event callback cleanup if size starts to get larger than expected
	    // We don't want to handle the cleaning here in case TweenAddCallback is called during a tween event!
	    if (ds_list_size(_event) % 5 == 0)
	    {   
	        ds_priority_add(SharedTweener().eventCleaner, _event, _event);
	    }
	}
	else
	{	// Create event list
	    var _event = ds_list_create();
	    // Add STATE and CALLBACK to event
	    ds_list_add(_event, true, _cb);
	    // Add event to events map -- auto-destroyed when map is destroyed
		ds_map_add_list(_events, event, _event);
	}
	
	// Return callback array
	return _cb;
}



function TweenCallbackEnable(callback, enable)
{	/// @desc Enables/disables specified callbacks
	if (is_array(callback) && callback[TWEEN_CB.TWEEN] != TWEEN_NULL)
	{
	    callback[@ TWEEN_CB.ENABLED] = enable;
	}
}


function TweenCallbackInvalidate(callback) 
{	/// @desc Removes callback from its associated tween event
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
	    // Set callback tween as null to have it marked for removal
	    callback[@ TWEEN_CB.TWEEN] = TWEEN_NULL;
		callback[@ TWEEN_CB.ENABLED] = false;
	}
}


function TweenCallbackIsEnabled(cb) 
{	/// @desc Checks if callback is enabled
	if (is_array(callback))
	{
		return callback[TWEEN_CB.ENABLED];
	}
}


function TweenCallbackIsValid(callback) 
{	/// @desc Checks if callback id is valid
	/// return: bool
	/*      
	    Example:
	        if (TweenCallbackIsValid(callback))
	        {
	            TweenCallbackInvalidate(callback);
	        }
	*/
	
	if (is_array(callback))
	{
		if (TweenExists(callback[TWEEN_CB.TWEEN]) && TGMS_TargetExists(callback[TWEEN_CB.TARGET]))
		{
			return true;
		}
	}
	
	return false;
}


function TweenEventClear(_t, event)
{	/// @desc Invalidates all callbacks associated with tween event
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)

	// NOTE!!
	// We don't want to immediately clear the event list in case the event is actively being called!

	if (event == undefined)
	{
		show_error("No event given for TweenEventClear(tween, event)", false);	
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


function TweenEventEnable(_t, event, enable) 
{	/// @desc Enables/disables specified tween event
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


function TweenEventIsEnabled(_t, event) 
{	/// @desc Checks if tween event is enabled
	/// @param tween	tween id
	/// @param event	tween event macro (TWEEN_EV_*)

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



