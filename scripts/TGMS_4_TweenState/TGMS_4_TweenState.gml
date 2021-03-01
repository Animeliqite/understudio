/*
	It is safe to delete:
		TweenIsActive
		TweenIsPlaying
		TweenIsPaused
		TweenIsResting
		TweenJustStarted
		TweenJustFinished
		TweenJustStopped
		TweenJustPaused
		TweenJustResumed
		TweenJustRested
		TweenJustContinued
		TweenReverse
		TweenFinish
		TweenFinishDelay
*/

/// @func	TweenExists(tween) : bool
/// @desc	Checks if tween exists
function TweenExists(_t) 
{
	if (is_real(_t))
	{
		//SharedTweener(); // NOTE: Could adapt this into if statement later?
		// Inline version of SharedTweener()
		if (!instance_exists(o_SharedTweener))
		{
			instance_create_depth(0,0,0,o_SharedTweener);
		}
		
	    if (ds_map_exists(global.TGMS_TweenIndexMap, _t))
	    {
	        _t = global.TGMS_TweenIndexMap[? _t];
	    }
	    else
	    {
	        return false;
	    }
	}
	else
	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] == TWEEN_STATE.DESTROYED) 
		{ 
			return false; 
		}
	}
	else
	{
	    return false;
	}
    
	// _t now means target... this is an optimisation trick to avoid use of local vars
	_t = _t[TWEEN.TARGET];
	
	if (is_real(_t))
	{
		if (instance_exists(_t)) { return true; }

		instance_activate_object(_t);

		if (instance_exists(_t))
		{
		    instance_deactivate_object(_t);
		    return true;
		}
	}
	else
	if (weak_ref_alive(_t))
	{
		return true;
	}
	
	return false;
}


/// @func	TweenIsActive(tween) : bool
/// @desc	Checks if tween is active -- Returns true if tween is playing OR actively processing a delay
function TweenIsActive(_t) 
{
	_t = TGMS_FetchTween(_t);
	return is_undefined(_t) ? false : (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.DELAYED);
}


/// @func	TweenIsPlaying(tween) : bool
/// @desc	Checks if tween is playing
function TweenIsPlaying(_t)
{
	_t = TGMS_FetchTween(_t);
	return is_undefined(_t) ? false : _t[TWEEN.STATE] >= 0;
}


/// @func	TweenIsPaused(tween) : bool
/// @desc	Checks if tween is paused
function TweenIsPaused(_t) 
{
	_t = TGMS_FetchTween(_t);
	return is_undefined(_t) ? false : _t[TWEEN.STATE] == TWEEN_STATE.PAUSED;
}


/// @func TweenIsResting(tween, <just?>) : bool
/// @desc Checks if tween is resting
function TweenIsResting(_t) 
{
	_t = TGMS_FetchTween(_t);
	if (is_array(_t)) { return _t[TWEEN.REST] < 0; }
}


/// @func	TweenJustStarted(tween) : bool
/// @desc	Checks if tween just started playing in current step
function TweenJustStarted(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_PLAY], _t);
}


/// @func	TweenJustFinished(tween) : bool	
/// @desc	Checks to see if the tween just finished in current step
function TweenJustFinished(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_FINISH], _t);
}
	
	
/// @func	TweenJustStopped(tween) : bool
///	@desc	Checks if tween just stopped in current step
function TweenJustStopped(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_STOP], _t);
}


/// @func	TweenJustPaused(tween) : bool
/// @desc	Checks if tween was just paused in current step
function TweenJustPaused(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_PAUSE], _t);
}


/// @func	TweenJustResumed(tween) : bool
/// @desc	Checks if tween was just resumed in current step
function TweenJustResumed(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_RESUME], _t);
}


/// @func	TweenJustRested(tween) : bool
/// @desc	Checks if tween started to rest in current step
function TweenJustRested(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_REST], _t);	
}


/// @func	TweenJustContinued(tween) : bool
/// @desc	Checks if tween just continued in current step
function TweenJustContinued(_t) 
{
	return ds_map_exists(global.TGMS_EventMaps[TWEEN_EV_CONTINUE], _t);
}


/// @desc Stops selected tween[s]
function TweenStop(_t)
{
	/// TweenStop(tween[s])
	/// @param tween[s] tween id
	/// return: na

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] <= TWEEN_STATE.PAUSED)
	    {
	        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
        
	        if (_t[TWEEN.DELAY] >= 0) // NOTE: Careful with the -1 jump delays...
	        {
	            _t[@ TWEEN.DELAY] = -1;   
	            TGMS_ExecuteEvent(_t, TWEEN_EV_STOP_DELAY, 0);
	        }
	        else
	        {
	            TGMS_ExecuteEvent(_t, TWEEN_EV_STOP, 0);
	        }
            
	        if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }
	    }
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenStop);
	}
}


/// @desc Pauses selected tween[s]
function TweenPause(_t) 
{
	/// TweenPause(tween[s])
	/// @param tween[s] tween id
	/// return: na

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] >= 0) 
		{
	        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
	        TGMS_ExecuteEvent(_t, TWEEN_EV_PAUSE, 0);
	    }
		else 
		if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED) 
		{
	        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
	        TGMS_ExecuteEvent(_t, TWEEN_EV_PAUSE_DELAY, 0);
	    }
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenPause);
	}
}


/// @desc Resumes selected tween[s]
function TweenResume(_t) 
{
	/// TweenResume(tween[s])
	/// @param tween[s] tween id
	/// return: na

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{		
	    if (_t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {		
	        if (_t[TWEEN.DELAY] > 0)
	        {
	            _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED;
	            TGMS_ExecuteEvent(_t, TWEEN_EV_RESUME_DELAY, 0);
	        }
	        else
	        {
	            _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];
	            TGMS_ExecuteEvent(_t, TWEEN_EV_RESUME, 0);
	        }
	    }
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenResume);
	}
}


/// @desc Reverses selected tween[s]
function TweenReverse(_t) 
{
	/// TweenReverse(tween[s])
	/// @param tween[s] tween id
	/// return: na

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] > 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];
	        _t[@ TWEEN.SCALE] = -_t[TWEEN.SCALE];
	        TGMS_ExecuteEvent(_t, TWEEN_EV_REVERSE, 0);
	    }
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenReverse);
	}
}


/// @desc Finishes selected tween[s]
function TweenFinish(_t, _callEvent) 
{
	/// TweenFinish(tween[s],call_event)
	/// @param tween[s]		tween id
	/// @param call_event	execute FINISH EVENT callbacks?

	/*      
	    INFO:
	        Finishes the specified tween, updating it to its destination.
	        DOES NOT affect tweens using PATROL|LOOP|REPEAT play modes.
			(To be changed with continue counts)
	*/

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0) { return 0; }
    
	    if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        switch(_t[TWEEN.MODE])
	        {
	        case TWEEN_MODE_ONCE: 
				//> Set time to tween end
				_t[@ TWEEN.TIME] = _t[TWEEN.DURATION];
			break;
	        
			case TWEEN_MODE_BOUNCE: 
				//> Set time to tween start
				_t[@ TWEEN.TIME] = 0; 
			break;
			
			case TWEEN_MODE_PATROL:
				//> Exit script early if count is endless
				if (_t[TWEEN.CONTINUE_COUNT] <= -1) return;
				
				//> Determine start/end based on odd/even count
				if (_t[TWEEN.CONTINUE_COUNT] % 2 == 0) {
					_t[@ TWEEN.TIME] = _t[TWEEN.DIRECTION] == 1 ? _t[TWEEN.DURATION] : 0;
				}
				else {
					_t[@ TWEEN.TIME] = _t[TWEEN.DIRECTION] == 1 ? 0 : _t[TWEEN.DURATION];
				}	
			break;
			
			case TWEEN_MODE_LOOP:
				//> Exit script early if count is endless
				if (_t[TWEEN.CONTINUE_COUNT] <= -1) return;
				//> Set time to tween end
				_t[@ TWEEN.TIME] = _t[TWEEN.DURATION];	
			break;
			
			case TWEEN_MODE_REPEAT:
				//> Exit script early if count is endless
				if (_t[TWEEN.CONTINUE_COUNT] <= -1) return;
				//> Set time to tween end
				_t[@ TWEEN.TIME] = _t[TWEEN.DURATION];
				
				//> Loop through data array and change start positions
				var _data = _t[TWEEN.PROPERTY_DATA];
				var i = -2;
				repeat(_data[0])
				{
					i += 4;
					_data[@ i] += _data[i+1] * _t[TWEEN.CONTINUE_COUNT]; 
				}
			break;
	        }
        
			//> Set tween state as STOPPED
	        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED; 
	        //> Update property with start value
			TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
	        //> Execute finish event IF set to do so
	        if (_callEvent) { TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0); }
	        //> Destroy tween if it is set to be destroyed
	        if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }
	    }
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenFinish, _callEvent);
	}
}
	
	
/// @desc Finishes delay for selected tween[s]
function TweenFinishDelay(_t, _callEvent) 
{
	/// TweenFinishDelay(tween[s],callevent)
	/// @param tween[s]		tween id
	/// @param call_event	execute FINISH EVENT callbacks?

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0)
	    {
			//> Mark delay for removal from delay list
	        _t[@ TWEEN.DELAY] = -1;
	        //> Execute FINISH DELAY event
	        if (_callEvent) { TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH_DELAY, 0); }
			//> Set tween as active
	        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];                
			//> Process tween
			TGMS_TweenProcess(_t, 0, _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
			//> Execute PLAY event
	        TGMS_ExecuteEvent(_t, TWEEN_EV_PLAY, 0);
	    }
	}
	else
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenFinishDelay, _callEvent);
	}
}


/// @desc Manually destroys selected tween[s]
function TweenDestroy(_t) 
{
	/// @param tween[s]		tween id[s]
	/// return: null tween id
	/*
	    Note: Tweens are always automatically destroyed when their target instance is destroyed.
	*/

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
		if (_t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
		{
		    return undefined;
		}
    
		// NOTE: Don't need the extra map-check here, as the handle SHOULD always exist at this point, if reached
	
		// Invalidate tween handle
		ds_map_delete(global.TGMS_TweenIndexMap, _t[TWEEN.ID]);
    
		// NOTE: We don't have to destroy the property list here... that will be done in the auto-cleaner
	
		_t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
		_t[@ TWEEN.ID] = undefined; // Nullify self reference
    
		// Invalidate tween target or destroy target instance depending on destroy mode
		if (_t[TWEEN.DESTROY] == 2)
		{	
			if (is_real(_t[TWEEN.TARGET]))
			{
				// Destroy Target Instance
			    if (instance_exists(_t[TWEEN.TARGET]))
			    {
			        with(_t[TWEEN.TARGET]) instance_destroy(_t[TWEEN.TARGET]);
			    }
			    else
			    {
			        instance_activate_object(_t[TWEEN.TARGET]); // Attempt to activate target by chance it was deactivated
			        with(_t[TWEEN.TARGET]) instance_destroy(); // Attempt to destroy target
			    } 
			}
		}
	
		_t[@ TWEEN.TARGET] = noone; // Invalidate tween target
		return undefined;
	}
	else
	if (is_struct(_t))
	{
		TGMS_TweensExecute(_t, TweenDestroy);
	}

	return undefined;
}


/// @desc Forces tween to be destroyed when finished or stopped
function TweenDestroyWhenDone(_t, _destroy) 
{
	/// TweenDestroyWhenDone(tween[s], destroy, kill_target)
	/// @param	tween[s]		tween id(s)
	/// @param	destroy			destroy tween[s] when finished or stopped?
	/// @param	kill_target		(optional) destroy target when tween finished or stopped?

	if (argument_count == 3 && argument[2])
	{
		_destroy = 2;
	}

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
		_t[@ TWEEN.DESTROY] = _destroy;
	}
	else
	if (is_struct(_t))
	{
		TGMS_TweensExecute(_t, TweenDestroyWhenDone, _destroy);
	}
}


