/// @desc Clean System 
/*
	Hebrews 11:6
	And without faith it is impossible to please him,
	for whoever would draw near to God must believe that
	he exists and that he rewards those who seek him.
*/

if (global.TGMS.SharedTweener != noone)
{
	// Remove self as shared tweener singleton
    global.TGMS.SharedTweener = noone;
    // Destroy Tweens and Delays for Persistent Rooms
    TweenSystemClearRoom(all);
    // Clear id reference map
    ds_map_clear(global.TGMS.TweenIndexMap);
	// Clear Group Scales
	ds_map_clear(global.TGMS.GroupScales);
	// Clear Event Maps
	var i = -1;
	repeat(TWEEN_EV_COUNT)
	{
		ds_map_clear(global.TGMS.EventMaps[++i]);
	}

	//---------------------------------------------
	// Destroy remaining tweens
	//---------------------------------------------
	var _tweens = global.TGMS.tweens;
	var _tIndex = -1;
	repeat(ds_list_size(_tweens))
	{   
	    var _t = _tweens[| ++_tIndex];             // Get tween and increment iterator
	    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
	    _t[@ TWEEN.ID] = undefined;                // Nullify self reference
    
	    // Destroy tween events if events map exists
	    if (_t[TWEEN.EVENTS] != -1)
	    {
			ds_map_destroy(_t[TWEEN.EVENTS]);
	    }
	}

	//---------------------------------------
	// Destroy Data Structures
	//---------------------------------------
	ds_list_destroy(global.TGMS.tweens);
	ds_list_destroy(global.TGMS.delayedTweens);
	ds_map_destroy(global.TGMS.pRoomTweens);
	ds_map_destroy(global.TGMS.pRoomDelays);
	ds_priority_destroy(global.TGMS.eventCleaner);
	ds_queue_destroy(global.TGMS.stateChanger);
}






