/*
	It is safe to delete:
		TweePlayDelay
		TweenMore
		TweenScript
		TweenMoreScript
		TweenDefine	
*/


/// @func TweenFire(target, ease, mode, delta, delay, duration, prop, start, dest, ...)
/// @desc Tween a property between start/destination values (auto-destroyed)
function TweenFire()
{
	// target		instance to associate with tween (id or object index)
	// ease			easing script index id (e.g. EaseInQuad, EaseLinear)
	// mode			tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	// delta		whether or not to use delta(seconds) timing -- false will use step timing
	// delay		amount of time to delay tween before playing
	// dur			duration of time to play tween
	// prop			property setter string (e.g. "x") or TP*() script
	// start		starting value for eased property
	// dest			destination value for eased property
	// ...			(optional) additional properties ("direction", 0, 360) or advanced actions ("-group", 2)
	/*
		Info:
		    Eases one or more variables/properties between a specified start and destination value over a set duration of time.
		    Additional properties can be added as optional arguments. Additional properties must use (property,start,dest) order.
    
		Examples:                                  
		    // Ease "x" value from (x) to (mouse_x), over 1 second
		    TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", x, mouse_x);
        
		    // Ease "x" and "y" values from (x, y) to (mouse_x, mouse_y) over 60 steps with a 30 step delay.
		    // Tween will play back and forth, repeatedly.
		    TweenFire(obj_Player, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60, "x", x, mouse_x, "y", y, mouse_y);
	*/
	
	static _args = 0;
	static i = 0;
	
	if (is_string(argument[0]) || is_array(argument[0]))
	{
		_args = array_create(argument_count);
		i = -1;
		repeat(argument_count)
		{
			++i;
			_args[i] = argument[i];
		}
	}
	else
	{
		// I could speed this up with a special case supplying all min amount of elements as its own array
		//_args[0] = [""];
		//_args[1] = [argument[0], argument[1], argument[2], argument[3], argument[4], argument[5]];
		
		_args = [];
		array_push(_args, 
			TWEEN.TARGET, argument[0],
			TWEEN.EASE, argument[1],
			TWEEN.MODE, argument[2],
			TWEEN.DELTA, argument[3],
			TWEEN.DELAY, argument[4],
			TWEEN.DURATION, argument[5]
		);
		
		i = 5;
		repeat(argument_count-6)
		{
			array_push(_args, argument[++i]);
		}
	}
	
	return TGMS_Tween(TweenFire, _args, 0); // 3rd argument is not used here...
}

/// @function		TweenCreate(target, [ease, mode, delta, delay, dur, prop, start, dest, [...])
/// @description	Creates a tween to be started with TweenPlay*() (not auto-destroyed)
/// @return			Tween id
function TweenCreate() 
{
	// target	instance or struct to associate with tween
	// [Optional]
	// ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	// mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	// delta	whether or not to use delta(seconds) timing -- false will use step timing
	// delay	amount of time to delay tween before playing
	// dur		duration of time to play tween
	// prop		property setter string or TP*() script
	// start	starting value for eased property
	// dest		destination value for eased property
	// ...		(optional) additional properties ("direction", 0, 360)
	/*
		Creates and returns a new tween. The tween does not start right away, but must
		be played with the TweenPlay*() scripts.
		Unlike TwenFire*(), tweens created with TweenCreate() will exist in memory until either
		their target instance is destroyed or TweenDestroy(tween) is manually called.
		You can set them to auto-destroy with TweenDestroyWhenDone(tween, true):
	
		Defining a tween at creation is optional. Both of the following are valid:
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenDestroyWhenDone(tween2, true); // Have tween auto-destroy when finished
	*/
	
	if (argument_count == 1) 
	{
		_args = [TWEEN.TARGET, argument[0]];
	}
	else
	if (is_string(argument[0]) || is_array(argument[0]))
	{
		var _args = array_create(argument_count);
		var i = -1;
		repeat(argument_count)
		{
			++i;
			_args[i] = argument[i];
		}
	}
	else
	{
		var _args = array_create(argument_count+6);
		_args[0]  = TWEEN.TARGET; _args[1]  = argument[0];
		_args[2]  = TWEEN.EASE; _args[3]  = argument[1];
		_args[4]  = TWEEN.MODE; _args[5]  = argument[2];
		_args[6]  = TWEEN.DELTA; _args[7]  = argument[3];
		_args[8]  = TWEEN.DELAY; _args[9]  = argument[4];
		_args[10] = TWEEN.DURATION; _args[11] = argument[5];
	
		var i = 11;
		repeat(argument_count-6)
		{
			++i;
			_args[i] = argument[i-6];
		}
	}
	
	
	return TGMS_Tween(TweenCreate, _args, 0);
}

/// @func	TweenPlay(tween,[ease,mode,delta,delay,dur,prop,start,dest,...])
/// @desc	Plays a tween previously created with TweenCreate()
function TweenPlay() 
{
	// tween	tween[s] id of previously created tween
	// [ease	easing script index id (e.g. EaseInQuad, EaseLinear)
	// mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	// delta	whether or not to use delta/seconds timing(true) or step timing(false)
	// delay	amount of time to delay tween before playing
	// dur		duration of time to play tween
	// prop		property setter string or TP*() script
	// start	starting value for eased property
	// dest		destination value for eased property
	// ...		(optional) additional properties ("direction", 0, 360)
	/*
		Defining a tween at creation is optional. Both of the following are valid:
		
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenPlay(tween1, EaseInQuad, 0, true, 0, 1.0, "a", 0, 100);
			TweenPlay(tween2);
	*/
	
	var _args;

	if (argument_count == 1)
	{
		_args = [];
	}
	else
	if ((is_string(argument[1]) && global.TGMS_ShorthandTable[string_byte_at(argument[1], 1)]) || is_array(argument[1]))
	{
		_args = array_create(argument_count-1);
		var i = -1;
		repeat(argument_count-1)
		{
			++i;
			_args[i] = argument[i+1];
		}
	}
	else
	{
		_args = array_create(argument_count-1);
		_args[0] = TWEEN.EASE; _args[1] = argument[1];
		_args[2] = TWEEN.MODE; _args[3] = argument[2];
		_args[4] = TWEEN.DELTA; _args[5] = argument[3];
		_args[6] = TWEEN.DELAY; _args[7] = argument[4];
		_args[8] = TWEEN.DURATION; _args[9] = argument[5];
	
		var i = 9;
		repeat(argument_count-6)
		{
			++i;
			_args[i] = argument[i-4];
		}
	}
	
	return TGMS_Tween(TweenPlay, _args, argument[0]);
}


/// @func	TweenPlayDelay(tween[s], delay)
/// @desc	Plays tween[s] defined with TweenCreate*() after a set delay
/// @return n/a
function TweenPlayDelay(_t, delay) 
{
	// @param tween[s]	id of previously created/defined tween[s]
	// @param delay		amount of time to delay start

	_t = TGMS_FetchTween(_t);

	if (is_array(_t))
	{
	    _t[@ TWEEN.DELAY] = delay;
		TGMS_Tween(TweenPlay, [], _t[TWEEN.ID]);
	}
    
	if (is_struct(_t))
	{
	    TGMS_TweensExecute(_t, TweenPlayDelay, delay);
	}
}


/// @func	TweenMore(tween, target, ease, mode, delta, delay, dur, prop, start, dest, [...])
/// @desc	Allows for chaining of tweens by adding a tween to be fired after the indicated tween finishes	
/// @return	Tween id
function TweenMore() 
{
	/// @param tween	tween id
	/// @param target	instance to associate with tween (id or object index)
	/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
	/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
	/// @param delay	amount of time to delay tween before playing
	/// @param dur		duration of time to play tween
	/// @param prop		property setter string or TP*() script
	/// @param start	starting value for eased property
	/// @param dest		destination value for eased property
	/// @param [...]	(optional) additional properties ("direction", 0, 360)
	/*
	    Info:
			Allows for chaining of tweens by adding a tween to be fired after the indicated tween finishes.
			Multiple new tweens can be added to the same tween, allowing for branching chains.
			Tween is automatically destroyed when finished, stopped, or if its associated target instance is destroyed.
			Returns unique tween id.   
    
	    Examples:
	        // Chain various tweens to fire one after another
			tween1 = TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			tween2 = TweenMore(tween1, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			tween3 = TweenMore(tween2, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			tween4 = TweenMore(tween3, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
		
			t = TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			TweenMore(t, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			TweenMore(t+1, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			TweenMore(t+2, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
		
			// 0 can be used to refer to the last created tween
			TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			TweenMore(0, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			TweenMore(0, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			TweenMore(0, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
	*/

	var _tween = TGMS_FetchTween(argument[0]);

	if (is_string(argument[1]) || is_array(argument[1]))
	{
		var _args = array_create(argument_count-1);
		var i = -1;
		repeat(argument_count-1)
		{
			++i;
			_args[i] = argument[i+1];
		}
	}
	else
	{
		var _args = array_create(argument_count+5);
		_args[0]  = TWEEN.TARGET; _args[1]  = argument[1];
		_args[2]  = TWEEN.EASE; _args[3]  = argument[2];
		_args[4]  = TWEEN.MODE; _args[5]  = argument[3];
		_args[6]  = TWEEN.DELTA; _args[7]  = argument[4];
		_args[8]  = TWEEN.DELAY; _args[9]  = argument[5];
		_args[10] = TWEEN.DURATION; _args[11] = argument[6];
	
		var i = 11;
		repeat(argument_count-7)
		{
			++i;
			_args[i] = argument[i-5];
		}
	}

	var _newTween = TGMS_Tween(TweenCreate, _args, 0);
	var _t = TGMS_FetchTween(_tween);
	TweenDestroyWhenDone(_newTween, _t[TWEEN.DESTROY]);
	TweenAddCallback(_tween, TWEEN_EV_FINISH, SharedTweener(), TweenPlay, _newTween);
	return _newTween;
}


/// @func	TweenScript(target, delta, dur, script, [arg0,...])
/// @desc	Schedules a script to be executed after a set duration of time
/// @return	Tween id
function TweenScript() 
{
	/// target		target instance id
	/// delta		use seconds timing? (true=seconds | false = steps)
	/// dur			duration of time before script is called
	/// script		script to execute when timer expires
	/// [arg0,...]	(optional) arguments to pass to script
	/*
	    Info:
	        Schedules a script to be executed after a set duration of time.
	        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
			such as TweenPause(), TweenResume(), TweenMore(), etc...
    
	    Examples:
			// Display a message after 1 second
	        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
			// Schedule another script to be fired 2 seconds after first one finishes
			ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye, World!");
		
			// Fire a tween after showing second message
			t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
	*/

	static _args = 0;
	static i = 0; 
	
	_args = array_create(argument_count);
	// Using "?" to make sure "off-rails" tween fire is used...
	_args[0] = TweenFire("?", argument[0], TWEEN.DELTA, argument[1], TWEEN.DURATION, argument[2]); 
	_args[1] = TWEEN_EV_FINISH;
	_args[2] = argument[0]; // target
	_args[3] = argument[3]; // script
	
	i = 3;
	repeat(argument_count-4)
	{
		++i;
		_args[i] = argument[i];
	}
	
	script_execute_ext(TweenAddCallback, _args);
	return _args[0];
}


/// @func	TweenMoreScript(tween,target,delta,dur,script,[arg0,...])
/// @desc	Allows for the chaining of script scheduling
/// @return	Tween id
function TweenMoreScript() 
{
	// tween		tween id
	// target		target instance
	// delta		use seconds timing? (true=seconds | false = steps)
	// dur			duration of time before script is called
	// script		script to execute when timer expires
	// [arg0,...]	(optional) arguments to pass to script
	/*
	    Info:
	        Allows for the chaining of script scheduling.
	        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
			such as TweenPause(), TweenResume(), TweenMore(), etc...
    
	    Examples:
			// Display a message after 1 second
	        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
			// Schedule another script to be fired 2 seconds after first one finishes
			ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye!");
		
			// Fire a tween after showing second message
			t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
	*/

	static _ogTween = 0;
	static _newTween = 0;
	static _args = 0;
	static i = 0; 

	_ogTween = TGMS_FetchTween(argument[0]); // Note: This needs to be first inorder to support [0] relevant tween ids
	// Using "?" to make sure "off rails" tween fire is used...
	_newTween = TweenCreate("?", argument[1], TWEEN.DELTA, argument[2], TWEEN.DURATION, argument[3]);
	TweenDestroyWhenDone(_newTween, true);
	TweenAddCallback(_ogTween[TWEEN.ID], TWEEN_EV_FINISH, SharedTweener(), TweenPlay, _newTween);

	_args = array_create(argument_count-1);
	_args[0] = _newTween;
	_args[1] = TWEEN_EV_FINISH;
	_args[2] = argument[1]; // Target
	_args[3] = argument[4]; // Script
	
	// Add remaining script arguments
	i = 3;
	repeat(argument_count-5)
	{
		++i;
		_args[i] = argument[i+1];
	}
	
	script_execute_ext(TweenAddCallback, _args);
	return _newTween;
}


/// @func	TweenDefine(tween,[ease,mode,delta,delay,dur,prop,start,dest,...])
/// @desc	Allows you to redefine a tween
function TweenDefine() 
{
	// tween	tween[s] id of previously created tween
	// [ease	easing script index id (e.g. EaseInQuad, EaseLinear)
	// mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
	// delta	whether or not to use delta/seconds timing(true) or step timing(false)
	// delay	amount of time to delay tween before playing
	// dur		duration of time to play tween
	// prop		property setter string or TP*() script
	// start	starting value for eased property
	// dest		destination value for eased property
	// ...		(optional) additional properties ("direction", 0, 360)
	/*
		Defining a tween at creation is optional. Both of the following are valid:
		
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenPlay(tween1, EaseInQuad, 0, true, 0, 1.0, "a", 0, 100);
			TweenPlay(tween2);
	*/
	
	var _curTween = TGMS_FetchTween(argument[0]);
	
	// Get original values to reassign later
	var _ogID = _curTween[TWEEN.ID];
	var _ogTarget = _curTween[TWEEN.TARGET];
	var _ogState = _curTween[TWEEN.STATE];
	var _ogTime = _curTween[TWEEN.TIME];
	var _ogGroup = _curTween[TWEEN.GROUP];
	var _ogDirection = _curTween[TWEEN.DIRECTION];
	var _ogEvents = _curTween[TWEEN.EVENTS];
	var _ogDestroyState = _curTween[TWEEN.DESTROY];
	
	// Set tween values to defautls
	array_copy(_curTween, 0, global.TGMS_TweenDefault, 0, TWEEN.DATA_SIZE);
	
	// Reassign the original values we want to carry over
	_curTween[@ TWEEN.ID] = _ogID;
	_curTween[@ TWEEN.TARGET] = _ogTarget;
	_curTween[@ TWEEN.STATE] = _ogState;
	_curTween[@ TWEEN.TIME] = _ogTime;
	_curTween[@ TWEEN.GROUP] = _ogGroup;
	_curTween[@ TWEEN.DIRECTION] = _ogDirection;
	_curTween[@ TWEEN.EVENTS] = _ogEvents;
	_curTween[@ TWEEN.DESTROY] = _ogDestroyState;
	
	var _args;

	if (argument_count == 1)
	{
		_args = [];
	}
	else
	if ((is_string(argument[1]) && global.TGMS_ShorthandTable[string_byte_at(argument[1], 1)]) || is_array(argument[1]))
	{
		_args = array_create(argument_count-1);
		var i = -1;
		repeat(argument_count-1)
		{
			++i;
			_args[i] = argument[i+1];
		}
	}
	else
	{
		_args = array_create(argument_count-1);
		_args[0] = TWEEN.EASE; _args[1] = argument[1];
		_args[2] = TWEEN.MODE; _args[3] = argument[2];
		_args[4] = TWEEN.DELTA; _args[5] = argument[3];
		_args[6] = TWEEN.DELAY; _args[7] = argument[4];
		_args[8] = TWEEN.DURATION; _args[9] = argument[5];
	
		var i = 9;
		repeat(argument_count-6)
		{
			++i;
			_args[i] = argument[i-4];
		}
	}
	
	return TGMS_Tween(TweenDefine, _args, argument[0]);
}



