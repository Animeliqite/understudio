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

function TweenExists(_t) 
{	/// @desc	Checks if tween exists
	/// @func	TweenExists(tween)

	if (is_real(_t))
	{
		//SharedTweener(); // NOTE: Could adapt this into if statement later?
		// Inline version of SharedTweener()
		if (!instance_exists(o_SharedTweener))
		{
			instance_create_depth(0,0,0,o_SharedTweener);
		}
		
	    if (ds_map_exists(global.TGMS.TweenIndexMap, _t))
	    {
	        _t = global.TGMS.TweenIndexMap[? _t];
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


function TweenIsActive(_t) 
{	/// @desc	Checks if tween is active -- Returns true if tween is playing OR actively processing a delay
	/// @func	TweenIsActive(tween)

	if (is_real(_t))
	{
		_t = TGMS_FetchTween(_t);
		return is_undefined(_t) ? false : (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.DELAYED);
	}
	else
	if (is_array(_t))
	{
		var _tweens = _t;
		var _tIndex = -1;
		repeat(array_length(_tweens))
		{
			_t = TGMS_FetchTween(_tweens[++_tIndex]);
			if (!is_undefined(_t) && (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.DELAYED))
			{
				return true;	
			}
		}
	}
	else
	{
		var _tweens = SharedTweener().tweens;
		var _tIndex = -1; // Tween index iterator
		repeat(ds_list_size(_tweens))
        {
			_t = _tweens[| ++_tIndex];
			if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.DELAYED)
			{
				return true;	
			}
		}
	}
	
	return false;
}


function TweenIsPlaying(_t)
{	/// @desc	Checks if tween is playing
	/// @func	TweenIsPlaying(tween)
	
	if (is_real(_t))
	{
		_t = TGMS_FetchTween(_t);
		return is_undefined(_t) ? false : _t[TWEEN.STATE] >= 0;
	}
	else
	if (is_array(_t))
	{
		var _tweens = _t;
		var _tIndex = -1;
		repeat(array_length(_tweens))
		{
			_t = TGMS_FetchTween(_tweens[++_tIndex]);
			if (!is_undefined(_t) && _t[TWEEN.STATE] >= 0)
			{
				return true;	
			}
		}
	}
	else
	{
		var _tweens = SharedTweener().tweens;
		var _tIndex = -1; // Tween index iterator
		repeat(ds_list_size(_tweens))
        {
			if (_tweens[| ++_tIndex][TWEEN.STATE] >= 0)
			{
				return true;	
			}
		}
	}
	
	return false;
}


function TweenIsPaused(_t) 
{	/// @desc	Checks if tween is paused
	/// @func	TweenIsPaused(tween)
	
	_t = TGMS_FetchTween(_t);
	return is_undefined(_t) ? false : _t[TWEEN.STATE] == TWEEN_STATE.PAUSED;
}


function TweenIsResting(_t) 
{	/// @desc Checks if tween is resting
	/// @func TweenIsResting(tween)
	_t = TGMS_FetchTween(_t);
	if (is_array(_t)) { return _t[TWEEN.REST] < 0; }
}


function TweenJustStarted(_t) 
{	/// @desc	Checks if tween just started playing in current step
	/// @func	TweenJustStarted(tween)
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_PLAY], _t);
}


function TweenJustFinished(_t) 
{	/// @desc	Checks to see if the tween just finished in current step
	/// @func	TweenJustFinished(tween)
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_FINISH], _t);
}
	
	
function TweenJustStopped(_t) 
{	///	@desc	Checks if tween just stopped in current step
	/// @func	TweenJustStopped(tween)
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_STOP], _t);
}


function TweenJustPaused(_t) 
{	/// @desc	Checks if tween was just paused in current step
	/// @func	TweenJustPaused(tween)
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_PAUSE], _t);
}


function TweenJustResumed(_t) 
{	/// @desc	Checks if tween was just resumed in current step
	/// @func	TweenJustResumed(tween)
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_RESUME], _t);
}


function TweenJustRested(_t) 
{	/// @desc	Checks if tween started to rest in current step
	/// @func	TweenJustRested(tween)
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_REST], _t);	
}


function TweenJustContinued(_t) 
{	/// @desc	Checks if tween just continued in current step
	/// @func	TweenJustContinued(tween) : bool
	return ds_map_exists(global.TGMS.EventMaps[TWEEN_EV_CONTINUE], _t);
}


function TweenStop(_t)
{	/// @desc Stops selected tween[s]
	/// @func TweenStop(tween[s])

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


function TweenPause(_t) 
{	/// @desc Pauses selected tween[s]
	/// @func TweenPause(tween[s])

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


function TweenResume(_t) 
{	/// @desc Resumes selected tween[s]
	/// @func TweenResume(tween[s])

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


function TweenReverse(_t) 
{	/// @desc Reverses selected tween(s)
	/// @func TweenReverse(tween[s])

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


function TweenFinish(_t, _callEvent, _finishDelay, _callDelayEvent) 
{	/// @desc Finishes selected tween[s]
	/// @func TweenFinish(tween[s], [call_event?, finish_delay?, call_delay_event?])
	/*      
	    INFO:
	        Finishes the specified tween, updating it to its destination.
	        DOES NOT affect tweens using PATROL|LOOP|REPEAT play modes
	        when a specified continue count is not given.
	*/

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{	// Deal with delays
		if (_t[TWEEN.DELAY] > 0 && (is_undefined(_finishDelay) || _finishDelay))
	    {
			//> Mark delay for removal from delay list
	        _t[@ TWEEN.DELAY] = -1;
	        //> Execute FINISH DELAY event
	        if (is_undefined(_callDelayEvent) || _callDelayEvent) { TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH_DELAY, 0); }
			//> Set tween as active
	        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];                
			//> Preprocess tween
			TGMS_TweenPreprocess(_t);
			//> Process tween
			TGMS_TweenProcess(_t, 0, _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
			//> Execute PLAY event
	        TGMS_ExecuteEvent(_t, TWEEN_EV_PLAY, 0);
	    }
		
		// Return early if tween retained delay
	    if (_t[TWEEN.DELAY] > 0) { return 0; }
    
    	// Let's finish the tween!
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
	        if (is_undefined(_callEvent) || _callEvent) { TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH, 0); }
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

	
function TweenFinishDelay(_t, _callEvent) 
{	/// @desc Finishes delay for selected tween[s]
	/// @func TweenFinishDelay(tween[s], [call_event?])

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0)
	    {
			//> Mark delay for removal from delay list
	        _t[@ TWEEN.DELAY] = -1;
	        //> Execute FINISH DELAY event
	        if (is_undefined(_callEvent) || _callEvent) { TGMS_ExecuteEvent(_t, TWEEN_EV_FINISH_DELAY, 0); }
			//> Set tween as active
	        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];                
			//> Preprocess tween
			TGMS_TweenPreprocess(_t);
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


function TweenDestroy(_t) 
{	/// @desc Manually destroys selected tween[s]
	/// @func TweenDestroy(tween[s])
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
		ds_map_delete(global.TGMS.TweenIndexMap, _t[TWEEN.ID]);
    
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


function TweenDestroyWhenDone(_t, _destroy) 
{
	/// @desc Forces tween to be destroyed when finished or stopped
	/// @func TweenDestroyWhenDone(tween[s], destroy?, kill_target?)
	/// @param	tween[s]		tween id(s)
	/// @param	destroy?		destroy tween[s] when finished or stopped?
	/// @param	kill_target?	(optional) destroy target when tween finished or stopped?

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


