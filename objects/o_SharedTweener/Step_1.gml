/// @desc Process Tween Logic

//===================
// Clear Event Maps
//===================
var i = -1;
repeat(TWEEN_EV_COUNT)
{
	if (!ds_map_empty(global.TGMS.EventMaps[++i])) 
	{
		ds_map_clear(global.TGMS.EventMaps[i]);
	}
}

//=======================s
// Manage Delta Timing
//=======================
prevDeltaTime = deltaTime;      // Store previous practical delta time format
deltaTime = delta_time/1000000; // Update practical delta time value

// Let's prevent delta time from exhibiting sporadic behaviour, shall we?
// IF the delta time is greater than the max delta limit...
if (deltaTime > maxDelta)
{
	deltaTime = deltaRestored ? maxDelta : prevDeltaTime; // Use max delta if restored, else use the previous delta time value
	deltaRestored = true; // Mark delta time as being restored
}
else
{
    deltaRestored = false; // Clear restored flag
}

deltaTime += addDelta; // Adjust for update interval difference -- only relevant if update interval not reached in previous step

//=================================
// Process Main Update Loop
//=================================
var _tweens = tweens; // Cache main tweens list
inUpdateLoop = true;  // Mark update loop as being processed

// IF the system is active
if (isEnabled)
{     
    tick++; // Increment step tick
	addDelta = tick < updateInterval ? addDelta+deltaTime : 0; // Make adjustment for delta time if update interval not achieved
    
    // WHILE the system tick is greater than the set step update interval -- UPDATE FOR DELTA TIMING???
    while (tick >= updateInterval)
    {   
        tick -= updateInterval; // Decrement step tick by update interval value
		
		var _groupScales = global.TGMS.GroupScales;
		var _timeScale = timeScale; // Cache time scale
		var _timeScaleDelta = _timeScale*deltaTime; // Cache time scale affected by delta time
		
        // IF system time scale isn't "paused"
        if (_timeScale != 0)
        {  
            //========================================
            // Process Tweens
            //========================================
            var _tIndex = -1; // Tween index iterator
			repeat(tweensProcessNumber)
            {
				 // Get next tween 
                var _t = _tweens[| ++_tIndex];
                
                // Process tween if target/state exists/active
				var _target = _t[TWEEN.STATE];
				
				if (TGMS_USE_TARGETS == TGMS_TARGETS_DYNAMIC)
				{
					if (is_numeric(_target)) // is instance id
					{
						if (!instance_exists(_target)) { continue; }
					}
					else // is struct
					{
						if (!weak_ref_alive(_target)) { continue; }
						_target = _target.ref;
					}
				}
				
				if (TGMS_USE_TARGETS == TGMS_TARGETS_INSTANCE)
				{
					if (!instance_exists(_target)) { continue; }
				}
				
				if (TGMS_USE_TARGETS == TGMS_TARGETS_STRUCT)
				{
					if (!weak_ref_alive(_target)) { continue; }
					_target = _target.ref;
				}
							
				// Cache updated time value for tween (multiply by relevant scale types (per / global/ group)
				// MACROS are used here for optimisation branches.
				// This will be optimised down to a single expression
				//		_time = ...
				var _time;
				if (TGMS_USE_GROUP_SCALES)
				{
					if (TGMS_USE_TIMING == TGMS_TIMING_DYNAMIC) 
						_time = _t[TWEEN.TIME] + _t[TWEEN.SCALE] * (_t[TWEEN.DELTA] ? _timeScaleDelta : _timeScale) * _groupScales[? _t[TWEEN.GROUP]];
					if (TGMS_USE_TIMING == TGMS_TIMING_DELTA) 
						_time = _t[TWEEN.TIME] + _t[TWEEN.SCALE] * _timeScaleDelta * _groupScales[? _t[TWEEN.GROUP]];
					if (TGMS_USE_TIMING == TGMS_TIMING_STEP)
						_time = _t[TWEEN.TIME] + _t[TWEEN.SCALE] * _timeScale * _groupScales[? _t[TWEEN.GROUP]];
				}
				else
				{
					if (TGMS_USE_TIMING == TGMS_TIMING_DYNAMIC)
						_time = _t[TWEEN.TIME] + _t[TWEEN.SCALE] * (_t[TWEEN.DELTA] ? _timeScaleDelta : _timeScale);
					if (TGMS_USE_TIMING == TGMS_TIMING_DELTA)
						_time = _t[TWEEN.TIME] + _t[TWEEN.SCALE] * _timeScaleDelta;
					if (TGMS_USE_TIMING == TGMS_TIMING_STEP)
						_time = _t[TWEEN.TIME] + _t[TWEEN.SCALE] * _timeScale;
				}
				
                // IF tween is within start/destination
                if (_time > 0 && _time < _t[TWEEN.DURATION])
                {
					// Assign updated time
                    _t[@ TWEEN.TIME] = _time;
					
					// Process tween
					// TGMS_TweenProcess(_t, _time, _t[TWEEN.PROPERTY_DATA], _target);
					//continue;
					// Inline version of TGMS_TweenProcess() for improved performance
					var data = _t[TWEEN.PROPERTY_DATA];
					switch(data[0]) // Property Count
					{
					case 1:
						if (is_method(_t[TWEEN.EASE])) data[1](_t[TWEEN.EASE](_time, data[2], data[3], _t[TWEEN.DURATION], _t), _target, data[4], _t); // data[4] is variable string name
						else						   data[1](data[2] + data[3]*animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]), _target, data[4], _t); 
					break;
					
					case 2:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
						data[1](_time*data[3]+data[2], _target, data[4], _t);
						data[5](_time*data[7]+data[6], _target, data[8], _t);
					break;
					
					case 3:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
					    data[1](_time*data[3]+data[2], _target, data[4], _t);
					    data[5](_time*data[7]+data[6], _target, data[8], _t);
					    data[9](_time*data[11]+data[10], _target, data[12], _t);
					break;
					
					case 4:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
					    data[1](_time*data[3]+data[2], _target, data[4], _t);
					    data[5](_time*data[7]+data[6], _target, data[8], _t);
					    data[9](_time*data[11]+data[10], _target, data[12], _t);
						data[13](_time*data[15]+data[14], _target, data[16], _t);
					break;
					
					case 5:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
					    data[1](_time*data[3]+data[2], _target, data[4], _t);
					    data[5](_time*data[7]+data[6], _target, data[8], _t);
					    data[9](_time*data[11]+data[10], _target, data[12], _t);
					    data[13](_time*data[15]+data[14], _target, data[16], _t);
					    data[17](_time*data[19]+data[18], _target, data[20], _t);
					break;
					
					case 6:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
					    data[1](_time*data[3]+data[2], _target, data[4], _t);
					    data[5](_time*data[7]+data[6], _target, data[8], _t);
					    data[9](_time*data[11]+data[10], _target, data[12], _t);
					    data[13](_time*data[15]+data[14], _target, data[16], _t);
					    data[17](_time*data[19]+data[18], _target, data[20], _t);
					    data[21](_time*data[23]+data[22], _target, data[24], _t);
					break;
					
					case 7:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
					    data[1](_time*data[3]+data[2], _target, data[4], _t);
					    data[5](_time*data[7]+data[6], _target, data[8], _t);
					    data[9](_time*data[11]+data[10], _target, data[12], _t);
					    data[13](_time*data[15]+data[14], _target, data[16], _t);
					    data[17](_time*data[19]+data[18], _target, data[20], _t);
					    data[21](_time*data[23]+data[22], _target, data[24], _t);
					    data[25](_time*data[27]+data[26], _target, data[28], _t);
					break;
					
					case 8:
						_time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](_time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]);
					    data[1](_time*data[3]+data[2], _target, data[4], _t);
					    data[5](_time*data[7]+data[6], _target, data[8], _t);
					    data[9](_time*data[11]+data[10], _target, data[12], _t);
					    data[13](_time*data[15]+data[14], _target, data[16], _t);
					    data[17](_time*data[19]+data[18], _target, data[20], _t);
					    data[21](_time*data[23]+data[22], _target, data[24], _t);
					    data[25](_time*data[27]+data[26], _target, data[28], _t);
						data[29](_time*data[31]+data[30], _target, data[32], _t);
					break;
					
					case 0: // Break out for tween with no properties
					break;
					
					default: // Handle "unlimited" property count
						var i = 1;
						var data = _t[TWEEN.PROPERTY_DATA];
						
						if (is_method(_t[TWEEN.EASE]))
						{	repeat(data[0])
							{	
								data[1](_t[TWEEN.EASE](_time, data[2], data[3], _t[TWEEN.DURATION], _t), _target, data[4], _t);
								i += 4;
							}
						}
						else
						{	repeat(data[0])
							{
								data[i](data[i+1] + data[i+2]*animcurve_channel_evaluate(_t[TWEEN.EASE], _time/_t[TWEEN.DURATION]), _target, data[i+3], _t);	
								i += 4;
							}
						}
					break;
					}
					
				}
                else // Tween has reached start or destination
				{
					TweenHasReachedBounds(_t, _target, _time, _timeScaleDelta, _groupScales);
				}
            }
			
			
			//==================================
            // Process Delays
            //==================================
            var _delayedTweens = delayedTweens; // Cache list of delayed tweens
			_tIndex = -1; // Reset tween index iterator
            repeat(delaysProcessNumber)
            {
                var _t = _delayedTweens[| ++_tIndex]; // Get next tween from delayed tweens list
    
                // IF tween instance exists AND delay is NOT destroyed
                if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED && (is_real(_t[TWEEN.TARGET])) ? instance_exists(_t[TWEEN.TARGET]) : weak_ref_alive(_t[TWEEN.TARGET]))
                { 
					// Decrement delay timer
					_t[@ TWEEN.DELAY] = _t[TWEEN.DELAY] - abs(_t[TWEEN.SCALE]) * (_t[TWEEN.DELTA] ? _timeScaleDelta : _timeScale);
					
                    // IF the delay timer has expired
                    if (_t[TWEEN.DELAY] <= 0)
                    {	
						// Remove tween from delay list
                        ds_list_delete(_delayedTweens, _tIndex--); 
						// Set time to delay overflow
						_t[@ TWEEN.TIME] = abs(_t[TWEEN.DELAY]);
						// Indicate that delay has been removed from delay list
                        _t[@ TWEEN.DELAY] = -1;										
                        // Execute FINISH DELAY event
						TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH_DELAY, 0);
						// Set tween as active 
                        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];  
						// Process tween data
						TGMS_TweenPreprocess(_t);
                        // Update property with start value                 
						TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref); // TODO: Verify that overflow is working
						// Execute PLAY event callbacks
						TGMS_ExecuteEvent(_t, TWEEN_EV_PLAY, 0);
                    }
                }
                else // If delay is marked for removal or tween is destroyed
                if (_t[TWEEN.DELAY] == -1 || _t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
                {
                    ds_list_delete(_delayedTweens, _tIndex--); // Remove tween from delay list
                }
            }
        }
    }
}


//==================================
// Event Cleaner -- This needs to stay above "Passive Tween Cleaner" to prevent errors
//==================================
if (ds_priority_size(eventCleaner))
{
    var _event = ds_priority_delete_min(eventCleaner); // Get event to check for cleaning

    // Cycle through all callbacks, except the new one -- make sure not to check event STATUS INDEX in event[0]
    var _cbCheckIndex = ds_list_size(_event);
    repeat(_cbCheckIndex-1)
    {
		var _cb = _event[| --_cbCheckIndex];
		
		if (_cb[TWEEN_CB.TWEEN] == TWEEN_NULL) 
		{
			ds_list_delete(_event, _cbCheckIndex); 
		}
		else
		{
			var _cbTarget = _cb[TWEEN_CB.TARGET];
			if (is_real(_cbTarget)) // Instance Target
			{	// Check if target doesn't exist
				if (!instance_exists(_cbTarget))
			    {	// Attempt to activate instance
					instance_activate_object(_cbTarget);
		    
				    if (instance_exists(_cbTarget))
					{	// Put instance back to deactivated state
				        instance_deactivate_object(_cbTarget);
				    }
				    else
				    {	// Remove callback from event
						ds_list_delete(_event, _cbCheckIndex); 
			    	}
			    }
			}
			else // Struct Target
			if (!weak_ref_alive(_cbTarget))
			{
				ds_list_delete(_event, _cbCheckIndex);
			}
		}
    }
}


//=========================================
// Passive Tween Cleaner
//=========================================
// Check to see if system is being flushed
// Else clamp number of cleaning iterations
var _cleanIterations;
if (flushDestroyed)
{
    flushDestroyed = false;                   // Clear "flush" flag
    autoCleanIndex = ds_list_size(_tweens);   // Set starting clean index to list size
    _cleanIterations = ds_list_size(_tweens); // Set number of iterations to list size 
}
else
{
    _cleanIterations = min(autoCleanIterations, autoCleanIndex, ds_list_size(_tweens)); // CLAMP!
}

// Start the cleaning!
repeat(_cleanIterations)
{   
    // Cache tween
    var _t = _tweens[| --autoCleanIndex];
    
    // IF tween target does not exist...
    if (is_numeric(_t[TWEEN.TARGET]))
	{
		if (!instance_exists(_t[TWEEN.TARGET]))
	    {
	        // Attempt to activate target instance
	        instance_activate_object(_t[TWEEN.TARGET]);
        
	        // IF instance now exists, put it back to deactivated state
	        if (instance_exists(_t[TWEEN.TARGET]))
	        {
	            instance_deactivate_object(_t[TWEEN.TARGET]);
	        }
	        else // Handle tween destruction...
	        {
				// Remove tween from tweens list
	            ds_list_delete(_tweens, autoCleanIndex);  
				// Set tween state as destroyed
				_t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED;
	            
				// Invalidate tween handle
	            if (ds_map_exists(global.TGMS.TweenIndexMap, _t[TWEEN.ID]))
	            {
	                ds_map_delete(global.TGMS.TweenIndexMap, _t[TWEEN.ID]);
				}
	            
				// Destroy tween events if events map exists
	            if (_t[TWEEN.EVENTS] != -1)
	            {
	                ds_map_destroy(_t[TWEEN.EVENTS]); // Destroy events map -- internal lists are marked
	            }
	        }
	    }
	}
	else
	{	// Let's see if the struct is 'dead'
		if (!weak_ref_alive(_t[TWEEN.TARGET]))
		{
			// Remove tween from tweens list
            ds_list_delete(_tweens, autoCleanIndex); 
			// Set tween state as destroyed
			_t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; 
            
			// Invalidate tween handle
            if (ds_map_exists(global.TGMS.TweenIndexMap, _t[TWEEN.ID]))
            {
                ds_map_delete(global.TGMS.TweenIndexMap, _t[TWEEN.ID]);
			}
            
			// Destroy tween events if events map exists
	        if (_t[TWEEN.EVENTS] != -1)
	        {
	            ds_map_destroy(_t[TWEEN.EVENTS]); // Destroy events map -- internal lists are marked
	        }
		}
	}
}

// Place auto clean index to size of tweens list if below or equal to 0
if (autoCleanIndex <= 0) { autoCleanIndex = ds_list_size(_tweens); }

// Indicate that we are finished processing the main update loop
inUpdateLoop = false;

// State Changer
repeat(ds_queue_size(stateChanger) div 2)
{
	var _t = ds_queue_dequeue(stateChanger);
	var _state = ds_queue_dequeue(stateChanger);
	
	if (TweenExists(_t))
	{
		_t[@ TWEEN.STATE] = _state;
	}
}



