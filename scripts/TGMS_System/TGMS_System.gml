


function SharedTweener() 
{
	if (instance_exists(o_SharedTweener))
	{
		return o_SharedTweener.id;	
	}
	
	return instance_create_depth(0,0,0,o_SharedTweener);	
}
	
	
function TGMS_FetchTween(tweenID) 
{
	if (is_array(tweenID))
	{
		return tweenID;
	}
	else
	if (is_real(tweenID))
	{
		// Inline SharedTweener() -- NOTE: might remove this later after adding TweenSetDefault and TweenGetDefault
		if (!instance_exists(o_SharedTweener))
		{
			instance_create_depth(0,0,0,o_SharedTweener);
		}
		
		// Check for tween in Tween Index Map
		if (ds_map_exists(global.TGMS.TweenIndexMap, tweenID))
		{
		    return global.TGMS.TweenIndexMap[? tweenID];
		}
		
		// Tween Offset Select
		if (!is_undefined(tweenID) && tweenID <= 0)
		{
			return global.TGMS.TweenIndexMap[? global.TGMS.TweenIndex-tweenID];	
		}
	}
	else // It's gotta be a struct, right? // TODO: THIS MIGHT BREAK WITH COMING GMS UPDATE!!
	if (is_struct(tweenID)) // Passed 'self' for a struct
	{
		return tweenID == self ? {target: tweenID} : tweenID;
	}
	else // Assume we have passed "self" for an instance
	if (tweenID != undefined)
	{
		return { target: tweenID.id };
	}
}


function TGMS_TargetExists(target) 
{
	if (is_real(target))
	{
		if (global.TGMS.TweensIncludeDeactivated)
		{		
		    if (instance_exists(target))
			{
		        return true;
		    }
    
			instance_activate_object(target);
    
		    if (instance_exists(target))
			{
		        instance_deactivate_object(target);
		        return true;
		    }
	
		    return false;
		}
		
		return instance_exists(target);
	}
	else
	{
		return weak_ref_alive(target);	
	}
}


function TGMS_StringStrip(_string, _offset) 
{	/// @desc Faster implementation for lowering strings and removing underscores	
	/// @func TGMS_StringStrip(string, offset)
	
	// Create static string cache
	static cache = ds_map_create();
	
	// Check cache for existing lowered string
	if (ds_map_exists(cache, _string))
	{
		return cache[? _string];
	}
	
	// Store original string
	static _string_og = "";
	_string_og = _string;
	
	// Remove underscores
	static _underscore = "_";
	static _empty = "";
	_string = string_replace_all(_string, _underscore, _empty);
	//_string = string_lettersdigits(_string); // This might be usable instead...
	
	// Convert string to lowercase
	repeat(string_length(_string)-_offset)
	{
		if (string_byte_at(_string, ++_offset) <= 90 && string_byte_at(_string, _offset) >= 65)
		{
			_string = string_set_byte_at(_string, _offset, 32+string_byte_at(_string, _offset));
		}
	}

	// Store new string into cache
	cache[? _string_og] = _string;
	// Return new lower case string
	return _string;
}


function TGMS_Tween(script, args, tweenID)
{
	static STR_AT = "@";
	static str_ref = "ref";
	static str_path_positionprevious = "path_positionprevious";
	
	var _t, _tID, _pData;
	var _doStart = true;
	
	static _sharedTweener = SharedTweener();
	if (!instance_exists(_sharedTweener))
	{
		_sharedTweener = SharedTweener();	
	}

	if (script == TweenDefine)
	{
		_tID = (tweenID > 0) ? tweenID : global.TGMS.TweenIndexMap[? global.TGMS.TweenIndex-tweenID]; // Cache tween id

		if (!TweenExists(_tID))
		{
			return 0;
		}
		
		_t = TGMS_FetchTween(_tID);  // Fetch raw tween data
		_t[@ TWEEN.CALLER] = is_struct(self) ? weak_ref_create(self) : id; // Struct or Instance calling the script
		_pData = []; // Set new property data array
	}
	else
	if (script == TweenPlay)
	{	
		if (is_array(tweenID))
		{
			_tID = tweenID;	
		}
		else
		{
			_tID = (tweenID > 0) ? tweenID : global.TGMS.TweenIndexMap[? global.TGMS.TweenIndex-tweenID]; // Cache tween id
		}
		
		if (!TweenExists(_tID))
		{
			return 0;
		}
		
		_t = TGMS_FetchTween(_tID);  // Fetch raw tween data
		_pData = _t[TWEEN.PROPERTY_DATA_RAW]; // Cache existing variable data list
		_t[@ TWEEN.DIRECTION] = 1;
		_t[@ TWEEN.SCALE] = abs(_t[TWEEN.SCALE]);
		_t[@ TWEEN.TIME] = 0;
		
		if (array_length(args))
		{	//^ IF NEW ARGUMENTS ARE SUPPLIED
			_pData = [];
			_t[@ TWEEN.AMOUNT] = 0;
			_t[TWEEN.CALLER] = is_struct(self) ? weak_ref_create(self) : id; // Struct or Instance calling the script
		}
	}
	else
	{
		_tID = ++global.TGMS.TweenIndex;			// Get new unique tween id
		_t = global.TGMS.TweenDefault;				// Get default tween base
		_t[TWEEN.ID] = _tID;						// New tween created with unique id
		_t[TWEEN.CALLER] = is_struct(self) ? weak_ref_create(self) : id; // Struct or Instance calling the script
		_t[TWEEN.TARGET] = _t[TWEEN.CALLER];	// Set default target to caller id
		_t[TWEEN.DESTROY] = (script == TweenCreate ? 0 : 1);  // Make persistent?
		ds_list_add(_sharedTweener.tweens, _t);		// Add tween to global tweens list
		global.TGMS.TweenIndexMap[? _tID] = _t;		// Associate tween with global id
		_pData = [];
	}

	var _paramCount = array_length(args)-1; // Number or paramters supplied
	var _qCallbacks = -1;					// Null value for callback queue
	var i = -1;								// Loop iterator
	var _p = -3;							// pData index .. THIS IS NEW!

	// Loop through AND process script parameters
	while(i < _paramCount)
	{		
		// Get next tag
		var _tag = args[++i]; 
		
		// IF Advanced Property
		if (is_array(_tag))
		{
			var _argCount = array_length(_tag);
			var _command = _tag[0];
			var _toFrom = 58; // ":"
			var _firstArg = _argCount > 1 ? _tag[1] : 0;

			if (_command == TPTarget)
			{	
				_firstArg = _tag[2];
				_tag[@ 2] = _tag[1];
				var _lastByte = string_byte_at(_firstArg, string_length(_firstArg));
			
				//if (">" or "<" or ":")
				if (_lastByte <= 62 && _lastByte >= 58)
				{	
					_toFrom = _lastByte;
					_firstArg = string_delete(_firstArg, string_length(_firstArg), 1);
				}
			}
			else
			if (is_string(_firstArg))
			{
				_firstArg = _argCount >= 2 ? _tag[1] : undefined;
				
				var _lastByte = string_byte_at(_firstArg, string_length(_firstArg));
			
				//if (">" or "<" or ":")
				if (_lastByte <= 62 && _lastByte >= 58)
				{	
					_toFrom = _lastByte;
					_firstArg = string_delete(_firstArg, string_length(_firstArg), 1);
				}

				// NOTE: This might need to be updated for proper target handling
				if (_command == TPUser)
				{
					_firstArg = TGMS_Variable_Get(id, _firstArg, id);
				}
			}
				
			switch(_argCount)
			{
			case 1: _tag = [_command, undefined]; break;
			case 2: _tag = ds_map_exists(global.TGMS.PropertyNormals, _command) ? [_command, [_firstArg, 0, 0]] : [_command, _firstArg]; break;
			default:
				var _xargs = array_create(_argCount-1);
				var _iArg = 0;
				_xargs[0] = _firstArg;
				
				repeat(_argCount-2)
				{
					++_iArg;
					_xargs[_iArg] = _tag[_iArg+1];
				}
				
				_tag = [_command, _xargs];
			}
			
			// Increment pData index
			_p += 3;
			
			switch(_toFrom)
			{
			case 58: // : Default
				i += 2; 
				array_push(_pData, _tag, args[i-1], args[i]);
			break;
				
			case 62: // > To
				array_push(_pData, _tag, STR_AT, args[++i]);
			break; 
				
			case 60: // < From
				array_push(_pData, _tag, args[++i], STR_AT);
			break;
			}
		}
		else // Not an advanced property...
		{		
			var _argLabel = (is_string(_tag)) ? global.TGMS.ArgumentLabels[? TGMS_StringStrip(_tag, 0)] : _tag;
			
			// NEW
			if (is_numeric(_argLabel))
			{
				switch(is_string(_tag) * string_byte_at(_tag, 1))
				{
					case 0:
					default:
						var _nextArg = args[++i];
				
						if (is_string(_nextArg))
						{
							switch(_argLabel)
							{
								case TWEEN.EASE: _t[@ TWEEN.EASE] = global.TGMS.ShortCodesEase[? TGMS_StringStrip(_nextArg, 0)]; break;
								case TWEEN.MODE: _t[@ TWEEN.MODE] = global.TGMS.ShortCodesMode[? TGMS_StringStrip(_nextArg, 0)]; break;
							}
						}
						else
						{
							_t[@ _argLabel] = _nextArg;
						}
					break;
						
					// "@" Event Callback -- This makes sure that we use the right assigned target before actually adding the callbacks later in this function
					case 64:
						/* TODO: Add "@update" 
						if (_argLabel == -1) // THIS MEANS "@update" -- special case
						{
							array_push(_pData, _tag, args[i-1], args[i]);
						}
						else
						*/
						{
							if (_qCallbacks == -1) { _qCallbacks = ds_queue_create(); }
							ds_queue_enqueue(_qCallbacks, _argLabel, args[++i]);
						}
					break;
				
					// ">" Count OR ">>" Chain
					case 62:
						// Check for ">count" first
						if (string_length(_tag) == 1)
						{
							_t[@ _argLabel] = args[++i];
							break;
						}
					
						// Else we have a chain
						_doStart = false; // Tell system not to play the tween right away
				
						if (i < _paramCount && is_real(args[i+1])) // ADD PLAY CHAIN TO SELECTED TWEEN
						{	
							++i;
							TweenAddCallback(args[i] ? args[i] : args[i]+global.TGMS.TweenIndex, TWEEN_EV_FINISH, _sharedTweener, TweenPlay, _tID); // Use index based on whether or not greater than 0 ... -1
						}
						else // < ADD PLAY CHAIN TO PREVIOUSLY CREATED TWEEN
						{	
							TweenAddCallback(global.TGMS.TweenIndex-1, TWEEN_EV_FINISH, _sharedTweener, TweenPlay, _tID);
						}
					break;
				} 
				
				_nextArg = undefined; // TODO: Check if this is needed for clear struct
			}
			else // Shorthand setters
			{
				var _shortIndex = global.TGMS.ShorthandTable[string_byte_at(_tag, 1)];
			
				if (_shortIndex) // CHECK FOR SHORTHAND SETTER
				{			
					switch(_shortIndex)
					{
						case TWEEN.EASE: _t[@ TWEEN.EASE] = global.TGMS.ShortCodesEase[? TGMS_StringStrip(_tag, 1)]; break;
						case TWEEN.MODE: _t[@ TWEEN.MODE] = global.TGMS.ShortCodesMode[? TGMS_StringStrip(_tag, 1)]; break;
						default: _t[@ _shortIndex] = real(string_delete(_tag, 1, 1)); break;
					}
				}
				else // WE HAVE A VARIABLE PROPERTY
				{
					_p += 3;
					
					switch(string_byte_at(_tag, string_length(_tag)))
					{		
					case 58: // :
						i += 2; 
						array_push(_pData, string_delete(_tag, string_length(_tag), 1), args[i-1], args[i]); 
					break;
				
					case 62: // > To
						array_push(_pData, string_delete(_tag, string_length(_tag), 1), STR_AT, args[++i]);
					break; 
				
					case 60: // < From
						array_push(_pData, string_delete(_tag, string_length(_tag), 1), args[++i], STR_AT);
					break;
						
					default:
						i += 2; 
						array_push(_pData, _tag, args[i-1], args[i]);
					}
				}
			}
		}
	}

	
	if (_t[TWEEN.GROUP] != 0)
	{	// Default group scale to 1.0 if it doesn't exit
		if (!ds_map_exists(global.TGMS.GroupScales, _t[TWEEN.GROUP]))
		{
			global.TGMS.GroupScales[? _t[TWEEN.GROUP]] = 1.0;	
		}
	}
	
	// Assign newly created variable data list
	_t[@ TWEEN.PROPERTY_DATA_RAW] = _pData;
	
	// Finalize used target -- If it WALKS like a duck and SOUNDS like a duck... it better be a duck!
	if (is_real(_t[TWEEN.TARGET]) || is_real(_t[TWEEN.TARGET][$ str_path_positionprevious]))
	{
		_t[@ TWEEN.TARGET] = _t[TWEEN.TARGET].id;
	}
	else // Set target as a weak reference if it isn't a weak reference already 
	if (variable_struct_names_count(_t[TWEEN.TARGET]) != 1 || _t[TWEEN.TARGET][$ str_ref] == undefined) // TODO: I might get rid of this and enforce NO WEAK REFERENCES!
	{
		_t[@ TWEEN.TARGET] = weak_ref_create(_t[TWEEN.TARGET]);
	}
	 
	// TODO: FIX THIS FOR HTML5... why is it not working... CHECK IF THIS IS FIXED ALREADY!
	// Set the active ease function -- convert "ease" string to function if needed
	if (is_string(_t[TWEEN.EASE]))
	{
		_t[@ TWEEN.EASE] = global.TGMS.ShortCodesEase[? TGMS_StringStrip(_t[TWEEN.EASE], 0)];
	}
	else
	if (is_real(_t[TWEEN.EASE]))
	{
		if (_t[TWEEN.EASE] < 100000) // Animation Curve ID
		{
			_t[@ TWEEN.EASE] = animcurve_get_channel(_t[TWEEN.EASE], 0);
		}
		else // Function ID
		{
			_t[@ TWEEN.EASE] = method(undefined, _t[TWEEN.EASE]);
		}
	}
	else
	if (is_array(_t[TWEEN.EASE])) // DERP
	{	
		// Convert ease strings into functions
		if (is_string(_t[TWEEN.EASE][0]))
		{
			_t[TWEEN.EASE][@ 0] = global.TGMS.ShortCodesEase[? TGMS_StringStrip(_t[TWEEN.EASE][0], 0)];
		}
		else
		if (is_real(_t[TWEEN.EASE][0]))
		{
			if (_t[TWEEN.EASE][0] < 100000)
			{
				_t[TWEEN.EASE][@ 0] = animcurve_get_channel(_t[TWEEN.EASE][0], 0);
			}
			else
			{
				_t[TWEEN.EASE][@ 0] = method(undefined, _t[TWEEN.EASE][0]);
			}
		}
		
		if (is_string(_t[TWEEN.EASE][1]))
		{
			_t[TWEEN.EASE][@ 1] = global.TGMS.ShortCodesEase[? TGMS_StringStrip(_t[TWEEN.EASE][1], 0)];
		}
		else
		if (is_real(_t[TWEEN.EASE][1]))
		{
			if (_t[TWEEN.EASE][1] < 100000)
			{
				_t[TWEEN.EASE][@ 1] = animcurve_get_channel(_t[TWEEN.EASE][1], 0);
			}
			else
			{
				_t[TWEEN.EASE][@ 1] = method(undefined, _t[TWEEN.EASE][1]);
			}
		}
		
		// Store raw tweens for swapping
		_t[@ TWEEN.EASE_RAW] = _t[TWEEN.EASE];
		// Set the active ease function
		_t[@ TWEEN.EASE] = _t[TWEEN.EASE][0];
	}
	
	if (!is_numeric(_t[TWEEN.MODE]))
	{
		if (is_string(_t[TWEEN.MODE]))
		{
			_t[@ TWEEN.MODE] = global.TGMS.ShortCodesMode[? TGMS_StringStrip(_t[TWEEN.MODE], 0)];
		}
		else
		if (is_array(_t[TWEEN.MODE]))
		{
			_t[@ TWEEN.CONTINUE_COUNT] = _t[TWEEN.MODE][1];
			_t[@ TWEEN.MODE] = is_real(_t[TWEEN.MODE][0]) ? _t[TWEEN.MODE][0] : global.TGMS.ShortCodesMode[? TGMS_StringStrip(_t[TWEEN.MODE][0], 0)];
		}
	}

	if (is_array(_t[TWEEN.DURATION]) && array_length(_t[TWEEN.DURATION]) == 2)
	{
		if (_t[TWEEN.DURATION][0] <= 0) { _t[TWEEN.DURATION][@ 0] = 0.0000001; }
		if (_t[TWEEN.DURATION][1] <= 0) { _t[TWEEN.DURATION][@ 1] = 0.0000001; }
		_t[@ TWEEN.DURATION_RAW] = _t[TWEEN.DURATION];
		_t[@ TWEEN.DURATION] = _t[TWEEN.DURATION][0];
	}
	
	if (is_array(_t[TWEEN.DELAY]))
	{
		_t[@ TWEEN.REST] = (array_length(_t[TWEEN.DELAY]) == 2) ? _t[TWEEN.DELAY][1] : [_t[TWEEN.DELAY][1], _t[TWEEN.DELAY][2]];
		_t[@ TWEEN.DELAY] = _t[TWEEN.DELAY][0];
	}	

	// HANDLE QUEUED CALLBACK EVENTS
	if (_qCallbacks != -1)
	{
		repeat(ds_queue_size(_qCallbacks) div 2)
		{
			var _event = ds_queue_dequeue(_qCallbacks);
			var _cbData = ds_queue_dequeue(_qCallbacks);
			
			// NEW --- working on this...
			// Need to add to the pData array
			// Insert if allowing for update_begin
			// Do I want to do "-update" or "@update"
			//TweenFire(id, "io", 0, true, 0, 1, "@update", DoThing, "x>", mouse_x, "@update", DoPostThing);
			/*
			if (_event == TWEEN_EV_UPDATE)
			{
				
			}
			else
			*/
			if (is_array(_cbData))
			{
				if (is_struct(_cbData[0]))
				{
					var _cArgs = array_create(array_length(_cbData) + 2);
					_cArgs[0] = _tID;
					_cArgs[1] = _event;
					_cArgs[2] = _cbData[0].target;
					array_copy(_cArgs, 3, _cbData, 1, array_length(_cbData)-1);
					script_execute_ext(TweenAddCallback, _cArgs);
				}
				else
				{
					var _cArgs = array_create(array_length(_cbData) + 3);
					_cArgs[0] = _tID;
					_cArgs[1] = _event;
					_cArgs[2] = _t[TWEEN.TARGET];
					array_copy(_cArgs, 3, _cbData, 0, array_length(_cbData));
					script_execute_ext(TweenAddCallback, _cArgs);
				}
			}
			else
			{
				TweenAddCallback(_tID, _event, _t[TWEEN.TARGET], _cbData);
			}
		}

		// Destroy temp callback queue
		ds_queue_destroy(_qCallbacks);	
	}

	// Return early if simply creating a new tween
	if (script == TweenCreate)
	{
		return _tID;
	}
	
	if (script == TweenDefine)
	{
		TGMS_TweenPreprocess(_t);
		_t[@ TWEEN.DELAY_START] = _t[TWEEN.DELAY]; // Update any existing delay
		return;
	}
	
	// Check for a delay
	if (_t[TWEEN.DELAY] != 0)
	{   
		if (_doStart)
		{
			_t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED; // Set tween as waiting 
		}
	
		// Put to starting tween position right away if a negative delay is given ( NOTE: This is a hidden feature! )
		if (_t[TWEEN.DELAY] < 0)
		{
			_t[@ TWEEN.DELAY] = abs(_t[TWEEN.DELAY]);
			TGMS_TweenPreprocess(_t);
			TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
		}
	
		_t[@ TWEEN.DELAY_START] = _t[TWEEN.DELAY];
		ds_list_add(_sharedTweener.delayedTweens, _t); // Add tween to delay list
	}
	else // Start tween right away
	if (_doStart)
	{		
		if (_sharedTweener.inUpdateLoop)
		{
			ds_queue_enqueue(_sharedTweener.stateChanger, _t, _t[TWEEN.TARGET]);	
		}
		else
		{
			_t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween as active
		}
		
		// Pre-process tween data
		TGMS_TweenPreprocess(_t);
		// Process tween
		TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA],  is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref); // TODO: Maybe allow this to be skipped ??
		// Execute "On Play" event
		TGMS_ExecuteEvent(_t, TWEEN_EV_PLAY, 0);
	}

	// Return tween id
	return _tID;
}


function TGMS_TweenPreprocess(_t) 
{	/// @func TGMS_TweenPreprocess(rawTween)
	static STR_AT = "@";
	static STR_AT_PLUS = "@+";
	static STR_EMPTY = "";
	static STR_SPACE = " ";
	static STR_DOLLAR = "$";
	static STR_DOT = ".";
	
	var _target = is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref;
	var _caller = is_real(_t[TWEEN.CALLER]) ? _t[TWEEN.CALLER] : _t[TWEEN.CALLER].ref;	

	var _dataSize = array_length(_t[TWEEN.PROPERTY_DATA_RAW]);
	var _propCount = _dataSize div 3;
	var _pData = [];
	array_copy(_pData, 0, _t[TWEEN.PROPERTY_DATA_RAW], 0, _dataSize);
	var _extIndex = -3; // Careful with this!
	var _extData = array_create(1+_propCount*4); // Create array holding properties data
	_extData[0] = _propCount; // Cache property count in first index (Used later when processing)
	
	// ** PARSE PROPERTY STRINGS **
	var i = -1;
	repeat(_propCount)
	{
		var _variable = _pData[++i];
	
		repeat(2)
		{
			var _pValue = _pData[++i];
		
			// RELATIVE ARRAY VALUES [100]
			if (is_array(_pValue))
			{	// Add "+" for positive numbers ... No "-" needed for negative numbers.
				_pValue = _pValue[0] >= 0 ? STR_AT_PLUS+string(_pValue[0]) : STR_AT+string(_pValue[0]);
			}
	
			// STRING VALUES (START DEST)
			if (is_string(_pValue))
			{	// Remove any spaces in string
				_pValue = string_replace_all(_pValue, STR_SPACE, STR_EMPTY); 

				// Check for initial minus sign
				var _preOp = 1;
				if (string_byte_at(_pValue, 1) == 45) // "-" minus
				{
					_preOp = -1;
					_pValue = string_delete(_pValue, 1, 1);
				}

				// TODO: THIS IS CAUSING AN ISSUE... POST-OP CAUSES PROBLEMS...
				var _op = 0;
				var _iOp = 1;
				repeat(string_length(_pValue)-2)
				{
					// TODO: add operator map check
					if (string_byte_at(_pValue, ++_iOp) != 46 && string_byte_at(_pValue, _iOp) <= 47 && string_byte_at(_pValue, _iOp) >= 42)
					{
						_op = _iOp;
						break;
					}
				}
			
				// Update TWEEN_SELF macro
				global.TGMS.tween_self = _t[TWEEN.ID];
			
				if (_op) // HANDLE MATH OPERATION
				{		
					var _pre = string_copy(_pValue, 1, _op-1);
					var _post = string_copy(_pValue, _op+1, string_length(_pValue)-_op);
	
					_pre = _pre == STR_AT ? TGMS_Variable_Get(_target, _variable, _caller) : TGMS_Variable_Get(_target, _pre, _caller);
					_post = _post == STR_AT ? TGMS_Variable_Get(_target, _variable, _caller) : TGMS_Variable_Get(_target, _post, _caller);

					// Perform operation
					switch(string_byte_at(_pValue, _op)) // TODO: Add _postOp??
					{
						case 43: _pData[i] = _preOp * _pre + _post; break; // +
						case 45: _pData[i] = _preOp * _pre - _post; break; // -
						case 42: _pData[i] = _preOp * _pre * _post; break; // *
						case 47: _pData[i] = _preOp * _pre / _post; break; // /
					}
				}
				else // NO MATH OPERATION
				{	
					_pData[i] = _pValue == STR_AT ? _preOp*TGMS_Variable_Get(_target, _variable, _caller) : _preOp*TGMS_Variable_Get(_target, _pValue, _caller);
				}
				
				// Clear TWEEN_SELF macro
				global.TGMS.tween_self = undefined;
			}
		}
		
		// ** PROCESS PROPERTY DATA VALUES **
		_extIndex += 4;
	
		if (is_array(_variable)) // ADVANCED PROPERTY
		{
			// Track raw property setter method
			_extData[_extIndex] = global.TGMS.PropertySetters[? _variable[0]];
			
			if (ds_map_exists(global.TGMS.PropertyNormals, _variable[0])) // NORMALIZED
			{	
				_extData[1+_extIndex] = 0; // normalized start
				_extData[2+_extIndex] = 1; // normalized change
				var _data = _variable[1];
				_data[@ 1] = _pData[i-1]; // start
				_data[@ 2] = _pData[i]; // change
			}
			else // NOT NORMALIZED
			{	
				_extData[1+_extIndex] = _pData[i-1]; // start
				_extData[2+_extIndex] = _pData[i] - _pData[i-1]; // change
			}
			
			_extData[3+_extIndex] = _variable[1]; // data
		}
		else // METHOD PROPERTY
		if (_target[$ STR_DOLLAR+_variable] != undefined)
		{
			_extData[  _extIndex] = _target[$ STR_DOLLAR+_variable];
			_extData[1+_extIndex] = _pData[i-1]; // start
			_extData[2+_extIndex] = _pData[i] - _pData[i-1]; // change
			_extData[3+_extIndex] = _variable; // data
		}
		else // OPTIMISED PROPERTY
		if (ds_map_exists(global.TGMS.PropertySetters, _variable))
		{
			//_variable = global.TGMS.PropertySetters[? _variable];
			//_extData[_extIndex] = _variable; // Track raw property
			_extData[_extIndex] = global.TGMS.PropertySetters[? _variable]; // Track raw property
			
			//if (!is_method(_variable) && ds_map_exists(global.TGMS.PropertyNormals, _variable))
			if (ds_map_exists(global.TGMS.PropertyNormals, _variable)) // NORMALIZED -- BUG IN HTML5 when checking method against a map
			{
				_extData[1+_extIndex] = 0; // normalized start
				_extData[2+_extIndex] = 1; // normalized change
				_extData[3+_extIndex] = [_pData[i-1], _pData[i]];
			}
			else // NOT NORMALIZED
			{	
				_extData[1+_extIndex] = _pData[i-1]; // start
				_extData[2+_extIndex] = _pData[i] - _pData[i-1]; // change
				_extData[3+_extIndex] = undefined; // data
			}
		}
		else // DYNAMIC PROPERTY
		{
			// NEW -- CHECK FOR STRUCTURE -- May need to extend this to support indexing object data
			var _dotPos = string_pos(STR_DOT, _variable);
			
			if (_dotPos) //
			{
				var _structName = string_copy(_variable, 1, _dotPos-1);
				{
					_extData[  _extIndex] = global.TGMS.Variable_Struct_String_Set;
					_extData[1+_extIndex] = _pData[i-1]; // start
					_extData[2+_extIndex] = _pData[i] - _pData[i-1]; // change
						
					if (_target[$ _structName] != undefined)
					{
						var _passTarget = _target[$ _structName];
						
						if (!is_real(_passTarget))
						{
							_passTarget = weak_ref_create(_passTarget);	
						}
						
						_extData[3+_extIndex] = [_passTarget,	string_copy(_variable, _dotPos+1, 100)];
						
					}
					else
					if (variable_global_exists(_structName))
					{
						var _passTarget = variable_global_get(_structName);
						
						if (!is_real(_passTarget))
						{
							_passTarget = weak_ref_create(_passTarget);	
						}
						
						_extData[3+_extIndex] = [_passTarget, string_copy(_variable, _dotPos+1, 100)];
					}
					else
					{
						var _objectID = asset_get_index(_structName);
						if (_objectID != -1)
						{
							_extData[3+_extIndex] = [_objectID.id,	string_copy(_variable, _dotPos+1, 100)];
						}
						else
						{
							show_error("Invalid tween property prefix! Check struct or object name.", false);	
						}
					}
				}
			}
			else
			{
				_extData[  _extIndex] = _target[$ _variable] == undefined ? global.TGMS.Variable_Global_Set : global.TGMS.Variable_Instance_Set;
				_extData[1+_extIndex] = _pData[i-1]; // start
				_extData[2+_extIndex] = _pData[i] - _pData[i-1]; // change
				_extData[3+_extIndex] = _variable; // data
			}
		}		
	}
	
	// NEW!!! ---- Deal with magnitude!!!!
	/*
	if (!is_method(_t[TWEEN.EASE]))
	{
		static str_tgms_use_magnitude = "tgms_use_magnitude";
		
		if (variable_struct_exists(_t[TWEEN.EASE], str_tgms_use_magnitude))
		{
			var i = 2;
			repeat(array_length(_extData) div 4)
			{
				_extData[i+1] += _extData[i]; // Convert to magnitude instead of destination
				i += 4;
			}
		}
	}
	*/
	

	// Assign property data values
	_t[@ TWEEN.PROPERTY_DATA] = _extData;
	
	// Handle per-step/second [durations]
	if (is_array(_t[TWEEN.DURATION]))
	{
		var _data = _t[TWEEN.PROPERTY_DATA];
		var _tempDur = _t[TWEEN.DURATION];
		var _repeatCount = array_length(_tempDur) == 2 ? _tempDur[1] : array_length(_data) div 4; 
		var _addedChange = 0;
		var i = 3;
							
		repeat(_repeatCount)
		{
			_addedChange += abs(_data[i]);
			i += 4;
		}
			
		_t[@ TWEEN.DURATION] = _addedChange/_tempDur[0]/_repeatCount;
	}
		
	// Make sure we don't have an invalid duration [0]
	if (_t[TWEEN.DURATION] <= 0)
	{
		_t[@ TWEEN.DURATION] = 0.000000001;	
	}
	
	// Adjust for amount
	if (_t[TWEEN.AMOUNT] > 0)
	{
		_t[@ TWEEN.TIME] = _t[TWEEN.AMOUNT] * _t[TWEEN.DURATION];	
	}
	//else
	//{
	//	_t[@ TWEEN.TIME] = 0; // Moved into TweenPlay case up above... was preventing "=0.5" from working
	//}
}


function TGMS_TweenProcess(_t, time, data, target) 
{ 	
	switch(data[0]) // Property Count
	{
	case 1:
		if (is_method(_t[TWEEN.EASE]))
		{
			data[1](_t[TWEEN.EASE](time, data[2], data[3], _t[TWEEN.DURATION], _t), target, data[4], _t);
		}
		else
		{
			data[1](data[2] + data[3]*animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]), target, data[4], _t); 
		}
	break;
	
	case 2:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
		data[1](time*data[3]+data[2], target, data[4], _t);
		data[5](time*data[7]+data[6], target, data[8], _t);
	break;
	
	case 3:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	break;
	
	case 4:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	break;
	
	case 5:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	    data[17](time*data[19]+data[18], target, data[20], _t);
	break;
	
	case 6:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	    data[17](time*data[19]+data[18], target, data[20], _t);
	    data[21](time*data[23]+data[22], target, data[24], _t);
	break;
	
	case 7:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	    data[17](time*data[19]+data[18], target, data[20], _t);
	    data[21](time*data[23]+data[22], target, data[24], _t);
	    data[25](time*data[27]+data[26], target, data[28], _t);
	break;
	
	case 8:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	    data[17](time*data[19]+data[18], target, data[20], _t);
	    data[21](time*data[23]+data[22], target, data[24], _t);
	    data[25](time*data[27]+data[26], target, data[28], _t);
	    data[29](time*data[31]+data[30], target, data[32], _t);
	break;
	
	case 9:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	    data[17](time*data[19]+data[18], target, data[20], _t);
	    data[21](time*data[23]+data[22], target, data[24], _t);
	    data[25](time*data[27]+data[26], target, data[28], _t);
	    data[29](time*data[31]+data[30], target, data[32], _t);
	    data[33](time*data[35]+data[34], target, data[36], _t);
	break;
	
	case 10:
		time = is_method(_t[TWEEN.EASE]) ? _t[TWEEN.EASE](time, 0, 1, _t[TWEEN.DURATION], _t) : animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]);
	    data[1](time*data[3]+data[2], target, data[4], _t);
	    data[5](time*data[7]+data[6], target, data[8], _t);
	    data[9](time*data[11]+data[10], target, data[12], _t);
	    data[13](time*data[15]+data[14], target, data[16], _t);
	    data[17](time*data[19]+data[18], target, data[20], _t);
	    data[21](time*data[23]+data[22], target, data[24], _t);
	    data[25](time*data[27]+data[26], target, data[28], _t);
	    data[29](time*data[31]+data[30], target, data[32], _t);
	    data[33](time*data[35]+data[34], target, data[36], _t);
	    data[37](time*data[39]+data[38], target, data[40], _t);
	break;
	
	case 0: // Break out for tweens with no properties
	break;
	
	default: // Handle "unlimited" properties
		var i = 1;				
		if (is_method(_t[TWEEN.EASE]))
		{	repeat(data[0])
			{
				data[1](_t[TWEEN.EASE](time, data[2], data[3], _t[TWEEN.DURATION], _t), target, data[4], _t);
				i += 4;
			}
		}
		else
		{	repeat(data[0])
			{
				data[i](data[i+1] + data[i+2]*animcurve_channel_evaluate(_t[TWEEN.EASE], time/_t[TWEEN.DURATION]), target, data[i+3], _t);	
				i += 4;
			}
		}
	break;
	}
}


function TGMS_ExecuteEvent(_t, eventType, index) 
{	/// @desc Executes tween callback events -- DO NOT CALL THIS DIRECTLY!!
	// Set events map for TweenIs*() checks
	ds_map_set(global.TGMS.EventMaps[eventType], _t[TWEEN.ID], 0);

	// IF events and event type initialized...
	if (_t[TWEEN.EVENTS] != -1)
	{
	    if (ds_map_exists(_t[TWEEN.EVENTS], eventType))
	    {
	        // Get event data
	        eventType = _t[TWEEN.EVENTS][? eventType];
			// Track Tween Self
			global.TGMS.tween_self = _t[TWEEN.ID];
			
	        // Iterate through all event callbacks (isEnabled * event list size)
	        repeat(eventType[| 0] * (ds_list_size(eventType)-1))
	        {	
	            _t = eventType[| ++index]; // Cache callback -- THIS IS ACTUALLY A CALLBACK... REUSING 'tween' to avoid local 'var' variable overhead!
   
				// First check to see if callback is to be removed
				if (_t[TWEEN_CB.TWEEN] == TWEEN_NULL)
				{
					ds_list_delete(eventType, index--);	
				}
				else // Execute callback script with proper number of arguments
				if (_t[TWEEN_CB.ENABLED])
				{
					with(is_real(_t[TWEEN_CB.TARGET]) ? _t[TWEEN_CB.TARGET] : _t[TWEEN_CB.TARGET].ref)
					{
						switch(array_length(_t)-TWEEN_CB.ARG)
						{
						case 0: _t = _t[TWEEN_CB.SCRIPT](); break;
						case 1: _t = _t[TWEEN_CB.SCRIPT](_t[TWEEN_CB.ARG]); break;
						case 2: _t = _t[TWEEN_CB.SCRIPT](_t[TWEEN_CB.ARG], _t[TWEEN_CB.ARG+1]); break;
						case 3: _t = _t[TWEEN_CB.SCRIPT](_t[TWEEN_CB.ARG], _t[TWEEN_CB.ARG+1], _t[TWEEN_CB.ARG+2]); break;
						case 4: _t = _t[TWEEN_CB.SCRIPT](_t[TWEEN_CB.ARG], _t[TWEEN_CB.ARG+1], _t[TWEEN_CB.ARG+2], _t[TWEEN_CB.ARG+3]); break;
						case 5: _t = _t[TWEEN_CB.SCRIPT](_t[TWEEN_CB.ARG], _t[TWEEN_CB.ARG+1], _t[TWEEN_CB.ARG+2], _t[TWEEN_CB.ARG+3], _t[TWEEN_CB.ARG+4]); break;
						default:
							switch(method_get_self(_t[TWEEN_CB.SCRIPT]))
							{
							case undefined:
								if (_t[TWEEN_CB.SCRIPT] >= 100000) // User Function
								{
									_t = script_execute_ext(_t[TWEEN_CB.SCRIPT], _t, TWEEN_CB.ARG);
								}
								else // Built-in Function -- error
								{
									// script_execute_ext() not working properly with built-in functions
									//with(method_get_self(_t[TWEEN_CB.SCRIPT])) _t = script_execute_ext(method_get_index(_t[TWEEN_CB.SCRIPT]), _t, TWEEN_CB.ARG0);
									show_message("TweenGMS: Callback argument count (5) exceeded!\n\nPlease convert the built-in function into a custom function or method inorder to support more arguments.");
								}
							break;
							case pointer_null: 
								_t = script_execute_ext(method_get_index(_t[TWEEN_CB.SCRIPT]), _t, TWEEN_CB.ARG); 
							break;
							default: 
								with(method_get_self(_t[TWEEN_CB.SCRIPT])) _t = script_execute_ext(method_get_index(_t[TWEEN_CB.SCRIPT]), _t, TWEEN_CB.ARG);
							}
						}
					}
					
					// NOTE: Document this change... 
					// Returning TGMS_REMOVE_CALLBACK from callback script will have the callback removed here after being called above ^
					if (is_string(_t) && _t == TGMS_REMOVE_CALLBACK)
					{
						ds_list_delete(eventType, index--);	
					}
				}
	        }
			
			// Clear "TWEEN_SELF"
			global.TGMS.tween_self = undefined;
	    }
	}
}


function TGMS_TweensExecute() 
{	/// @func TGMS_TweensExecute(tweens, script, [args0, ...])
	/*
		INFO:
		    Iterates through all relevant tweens and executes a specified script for each.
		    Currently takes only a max of 3 optional arguments.
	*/

	var _tweens = SharedTweener().tweens;
	var _argCount = argument_count-2;
	var _tStruct = argument[0];
	var _script = argument[1];
	var _tIndex = -1;
	var _args = array_create(1 + _argCount);
	var _argIndex = 0;
	repeat(_argCount)
	{
		++_argIndex;
		_args[_argIndex] = argument[_argIndex+1];
	}
	
	// TARGET SELECT
	static strTarget = "target";
	if (variable_struct_exists(_tStruct, strTarget))
	{	
		if (is_array(_tStruct.target)) // ARRAY
		{
			repeat(ds_list_size(_tweens))
			{
			    var _t = _tweens[| ++_tIndex];
			    var _target = _t[TWEEN.TARGET];
						
				if (TGMS_TargetExists(_target)) 
				{
					var i = -1;
					repeat(array_length(_tStruct.target))
					{
						var _selectionData = _tStruct.target[++i];
						
						if (_selectionData == _tStruct)
						{
							_selectionData = self;	
						}
								
						if (is_real(_target)) // instance target
						{
							if (!is_real(_selectionData))
							{
								static verify = "path_positionprevious"; // Making sure its an instance!
								if (_selectionData[$ verify] != undefined)
								{
									_selectionData = _selectionData.id; // Get the raw instance id
								}
								else
								{
									continue; // Exit out early if trying to compare against a struct target
								}
							}
							
							if (_target == _selectionData || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData))
							{
								_args[0] = _t;
								script_execute_ext(_script, _args, 0, 1+_argCount);
							}
						}
						else // struct target
						{
							if (_target.ref == _selectionData)
							{
								_args[0] = _t;
								script_execute_ext(_script, _args, 0, 1+_argCount);
							}
						}
					}
				}
			}
		}
		else
		if (_tStruct.target == all) // All Targets
		{	
			repeat(ds_list_size(_tweens))
			{
				var _t = _tweens[| ++_tIndex];
	            
				if (TGMS_TargetExists(_t[TWEEN.TARGET]))
				{
					_args[0] = _t;
					script_execute_ext(_script, _args, 0, 1+_argCount);
				}
			}
		}
		else // Specific Target
		{
			var _selectionData = (_tStruct == _tStruct.target) ? self : _tStruct.target;
			
			if (!is_real(_selectionData))
			{
				// Making sure its an instance!
				static verify = "path_positionprevious"; 
				if (_selectionData[$ verify] != undefined)
				{
					_selectionData = _selectionData.id; // Get the raw instance id
				}
			}
			
			repeat(ds_list_size(_tweens))
			{
				var _t = _tweens[| ++_tIndex];
		        var _target = _t[TWEEN.TARGET];
	
				if (TGMS_TargetExists(_target)) 
				{
					if (is_real(_target)) // Instance Target
					{
						if (is_real(_selectionData))
						{
							if (_target == _selectionData || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData))
							{
								_args[0] = _t;
								script_execute_ext(_script, _args, 0, 1+_argCount);
							}
						}
					}
					else // Struct Target
					{
						if (_target.ref == _selectionData)
						{
							_args[0] = _t;
							script_execute_ext(_script, _args, 0, 1+_argCount);
						}
					}
				}
			}
		}
	}
	
	// GROUP
	static strGroup = "group";
	if (variable_struct_exists(_tStruct, strGroup))
	{	// SINGLE
		if (is_real(_tStruct.group))
		{
			var _tIndex = -1;
			var _selectionData = _tStruct.group;
        
			repeat(ds_list_size(_tweens))
			{
		        var _t = _tweens[| ++_tIndex];
		        if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET]))
				{
					_args[0] = _t;
					script_execute_ext(_script, _args, 0, 1+_argCount);	
				}
		    }
		}
		else // ARRAY
		{
			var _tIndex = -1;
			
			repeat(ds_list_size(_tweens))
			{
		        var _t = _tweens[| ++_tIndex];
				var i = -1;
				repeat(array_length(_tStruct.group))
				{	
					var _selectionData = _tStruct.group[++i];
					if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET]))
					{
						_args[0] = _t;
						script_execute_ext(_script, _args, 0, 1+_argCount);
					}
				}
		    }
		}
	}
	
	// TWEEN STRUCT IDS
	static strTween = "tween";
	if (variable_struct_exists(_tStruct, strTween))
	{
		var _tIndex = -1;
		var _tweens = _tStruct.tween;
		
		// SINGLE
		if (is_real(_tweens))
		{
			var _t = TGMS_FetchTween(_tweens);
		    if (is_array(_t) && TGMS_TargetExists(_t[TWEEN.TARGET]))
			{
				_args[0] = _t;
				script_execute_ext(_script, _args, 0, 1+_argCount);
			}
		}
        else // ARRAY
		{
			repeat(array_length(_tweens))
			{
		        var _t = TGMS_FetchTween(_tweens[++_tIndex]);
		        if (is_array(_t) && TGMS_TargetExists(_t[TWEEN.TARGET]))
				{
					_args[0] = _t;
					script_execute_ext(_script, _args, 0, 1+_argCount);
				}
		    }
		}
	}
	
	// TWEEN LISTS OR ARRAYS
	static strList = "list";
	if (variable_struct_exists(_tStruct, strList))
	{
		var _tIndex = -1;
		var _tweens = _tStruct.list;
		
		if (is_array(_tweens))
		{
			repeat(array_length(_tweens))
			{
				var _t = TGMS_FetchTween(_tweens[++_tIndex]);
		        if (is_array(_t) && TGMS_TargetExists(_t[TWEEN.TARGET]))
				{
					_args[0] = _t;
					script_execute_ext(_script, _args, 0, 1+_argCount);
				}
			}
		}
		else // ds_list
		{
			repeat(ds_list_size(_tweens))
			{
				var _t = TGMS_FetchTween(_tweens[| ++_tIndex]);
		        if (is_array(_t) && TGMS_TargetExists(_t[TWEEN.TARGET]))
				{
					_args[0] = _t;
					script_execute_ext(_script, _args, 0, 1+_argCount);
				}
			}
		}
	}
}








