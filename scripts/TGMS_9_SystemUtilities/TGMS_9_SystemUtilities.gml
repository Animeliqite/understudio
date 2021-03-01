/*
	It is safe to delete:
		TweenSystemGet
		TweenSystemSet
		TweenSystemFlushDestroyed
*/


/// @desc Return value for selected tweening system property
function TweenSystemGet(dataLabel) 
{
	/// @param "dataLabel"
	/*
	    SUPPORTED DATA LABELS:
	        "enabled"			// is system enabled?
	        "time_scale"		// global time scale
	        "update_interval"	// how often system should update in steps (default = 1)
	        "min_delta_fps"		// minimum frame rate before delta time lags begin (default=10)
	        "auto_clean_count"	// number of tweens to check for auto-cleaning each step (default=10)
	        "delta_time"		// tweening systems internal delta time
	        "delta_time_scaled" // tweening systems scaled delta time
			"tween_count"			// returns total number of tweens in current room
			"tween_count_playing"	// returns total number of playing tweens
			"tween_count_paused"	// returns total number of paused tween
			"tween_count_stopped"	// returns total number of stopped tweens
	*/

	var _sharedTweener = SharedTweener();

	switch(dataLabel)
	{
	    case "delta_time":			return _sharedTweener.deltaTime;
	    case "delta_time_scaled":	return _sharedTweener.deltaTime * global.TGMS_TimeScale;
	    case "time_scale":			return global.TGMS_TimeScale;
		case "enabled": 			return global.TGMS_IsEnabled;
	    case "update_interval": 	return global.TGMS_UpdateInterval;
	    case "min_delta_fps":		return global.TGMS_MinDeltaFPS;
	    case "auto_clean_count":	return global.TGMS_AutoCleanIterations;
		case "tween_count": 		return ds_list_size(_sharedTweener.tweens);
	}

	/*
		Tween Counts!
	*/
	var _tweens = _sharedTweener.tweens;
	var _total = 0;
	var _index = -1;

	switch(dataLabel)
	{ 
	    case "tween_count_playing":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] >= 0;
	        }
	    break;
    
	    case "tween_count_paused":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] == TWEEN_STATE.PAUSED;
	        }
	    break;
    
	    case "tween_count_stopped":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] == TWEEN_STATE.STOPPED;
	        }
	    break;
	}

	return _total;
}


/// @desc Set value for specified tweening system property
function TweenSystemSet(dataLabel, value) 
{
	/// @param "dataLabel"
	/// @param value

	/*
	    SUPPORTED DATA LABELS:
	        "enabled"
	        "time_scale"
	        "update_interval"
	        "min_delta_fps"
	        "auto_clean_count"
	*/

	var _sharedTweener = SharedTweener();

	switch(dataLabel)
	{
	    case "enabled":
	        _sharedTweener.isEnabled = value;
	        global.TGMS_IsEnabled = value;
	    break;
    
	    case "time_scale":
	        _sharedTweener.timeScale = value;
	        global.TGMS_TimeScale = value;
	    break;
    
	    case "update_interval":
	        _sharedTweener.updateInterval = value;
	        global.TGMS_UpdateInterval = value;
	    break;
    
	    case "min_delta_fps":
	        global.TGMS_MinDeltaFPS = value;
	        _sharedTweener.minDeltaFPS = value;
	        _sharedTweener.maxDelta = 1/value;
	    break;
    
	    case "auto_clean_count":
	        global.TGMS_AutoCleanIterations = value;
	        _sharedTweener.autoCleanIterations = value;
	    break; 
	}
}


/// @desc Override memory manager to immediately clear destroyed tweens
function TweenSystemFlushDestroyed() 
{
	if (instance_exists(global.TGMS_SharedTweener))
	{
	    global.TGMS_SharedTweener.flushDestroyed = true;
	}
}


/// @desc Clear tweens in inactive persistent room(s)
function TweenSystemClearRoom(room) 
{
	// room	room index or [all] keyword for all rooms

	SharedTweener();
	var _pRoomTweens = global.TGMS.pRoomTweens;
	var _pRoomDelays = global.TGMS.pRoomDelays;
	var _key = room;

	// Clear all rooms if "all" keyword is used
	if (_key == all)
	{
		repeat(ds_map_size(_pRoomTweens))
		{
			TweenSystemClearRoom(ds_map_find_first(_pRoomTweens));
		}
	
		return 0;
	}

	// Destroy tweens for persistent room
	if (ds_map_exists(_pRoomTweens, _key))
	{
	    // Delete stored delays
	    ds_queue_destroy(ds_map_find_value(_pRoomDelays, _key));
	    ds_map_delete(_pRoomDelays, _key)
    
	    // Get stored tweens queue
	    var _queue = ds_map_find_value(_pRoomTweens, _key);
    
	    // Destroy all stored tweens in queue
	    repeat(ds_queue_size(_queue))
	    {
	        var _t = ds_queue_dequeue(_queue); // Get next tween from room's queue
        
	        // Invalidate tween handle
	        if (ds_map_exists(global.TGMS_TweenIndexMap, _t[TWEEN.ID]))
	        {
	            ds_map_delete(global.TGMS_TweenIndexMap, _t[TWEEN.ID]);
	        }
        
	        _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
	        _t[@ TWEEN.ID] = undefined; // Nullify self reference ... TODO: is this even needed?
        
	        // Destroy tween events if events map exists
	        if (_t[TWEEN.EVENTS] != -1)
	        {
				ds_map_destroy(_t[TWEEN.EVENTS]); // Destroy events map
			}
	    }
    
	    ds_queue_destroy(_queue);          // Destroy room's queue for stored tweens
	    ds_map_delete(_pRoomTweens, _key); // Delete persistent room id from stored tweens map
	}
}