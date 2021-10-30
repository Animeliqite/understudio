/*
	It is safe to delete:
		TweenGroupGetTimeScale
		TweenGetDefault
		TweenGroupSetTimeScale
		TweenSetDefault
*/


function TweenGroupGetTimeScale(group)
{	/// @func TweenGroupGetTimeScale(group)
	
	if (!ds_map_exists(global.TGMS.GroupScales, group))
	{	// Set a default group scale if it doesn't exist
		global.TGMS.GroupScales[? group] = 1.0;
	}
	
	return global.TGMS.GroupScales[? group];	
}

function TweenGroupSetTimeScale(_group, _timescale)
{	/// @func TweenGroupSetTimeScale(group, time_scale)
	
	global.TGMS.GroupScales[? _group] = _timescale;
}


function TweenGetDefault(_dataLabel)
{	/// @func TweenGetDefault("data_label")
	//	Supported Data Labels:
	//		"group" "delta" "scale" "ease" "mode" "duration" "rest" "amount" "continue_count"
	
	return TweenGet(TWEEN_DEFAULT, _dataLabel);
}


function TweenSetDefault(_dataLabel)
{	/// @func TweenSetDefault("data_label", _value, ...)
	//	Supported Data Labels:
	//		"group" "delta" "scale" "ease" "mode" "duration" "rest" "amount" "continue_count"
	
	var _args = array_create(argument_count+1);
	_args[0] = TWEEN_DEFAULT;
	
	var i = 0;
	repeat(argument_count)
	{
		++i;
		_args[i] = argument[i-1];
	}
	
	script_execute_ext(TweenSet, _args);
}


function TweenGet(_t, _dataLabel) 
{	/// @func TweenGet(tween, "data_label")
	/*
		PLEASE NOTE THAT THIS FUNCTION RETURNS [undefined] IF THE TWEEN DOES NOT EXIST!
	*/
	
	//	tween			tween id
	//	"dataLabel"		data "label" string -- see supported data labels below
	/*
	    Supported Data Labels:
	        "group"         -- Tween group
	        "time"          -- Current time of tween in steps or seconds
	        "amount"		-- Sets the tween's time by a relative amount between 0.0 and 1.0 
	        "scale"			-- How fast a tween updates : Default = 1.0
	        "duration"      -- How long a tween takes to fully animate in steps or seconds
	        "ease"          -- The easing algorithm used by the tween
	        "mode"          -- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
	        "target"        -- Target instance associated with tween
	        "delta"         -- Toggle timing between seconds(true) and steps(false)
	        "rest"
			"delay"         -- Current timer of active delay
	        "delay_start"   -- The starting duration for a delay timer
	        "start"         -- Start value of the property or properties
	        "destination"   -- Destination value of the property or properties
	        "property"      -- Property or properties effected by the tween
        
	        e.g.
	            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            duration = TweenGet(tween, "duration");
            
	    ***	WARNING *** The following labels return multiple values as an array for multi-property tweens:
        
				"start"    
				"destination"
				"property"
        
	        e.g.
	            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100);
	            startValues = TweenGet(tween, "start");
	            xStart = startValues[0];
	            yStart = startValues[1];
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) return undefined;
	
	_dataLabel = TGMS_StringStrip(_dataLabel, 0);
	
	switch(global.TGMS.TweenDataLabelMap[? _dataLabel])
	{
	    case TWEEN.PROPERTY:
			var _data = _t[TWEEN.PROPERTY_DATA_RAW];
			var _count = array_length(_data) div 3;
			
			if (_count == 1)
			{
				return _data[0];	
			}
			else
			{
				var _return = array_create(_count);
				var _iData = 0;
				var i = -1;
				repeat(_count)
				{
					_return[++i] = _data[_iData];
					_iData += 3;
				}
				
				return _return;
			}
	    break;
		
	    case TWEEN.DESTINATION: // TODO: Extend this to better handle raw data if stopped
			var _data = _t[TWEEN.PROPERTY_DATA];
			
			if (is_real(_data) || _t[TWEEN.DELAY] > 0)
			{
				_data = _t[TWEEN.PROPERTY_DATA_RAW];
				
				var _propCount = array_length(_data) div 3;
				
				if (_propCount == 1)
				{
					return _data[2];
				}

				var _ret = array_create(_propCount);
				var i = -1;
				var _iData = 2;
				repeat(_propCount)
				{
					_ret[++i] = _data[_iData];
					_iData += 3;
					
				}
					
				return _ret;
			}
			
			if (_data[0] == 1)
			{
				return _data[2]+_data[3];	
			}
			else
			{
				var _count = _data[0];
				var _return = array_create(_count);
				var _iData = 2;
				var i = -1;
				repeat(_count)
				{
					_return[++i] = _data[_iData]+_data[_iData+1];
					_iData += 4;
				}
				
				return _return;
			}
	    break;
    
	    case TWEEN.START: // TODO: Extend this to better handle raw data if stopped
			var _data = _t[TWEEN.PROPERTY_DATA];
			
			if (is_real(_data) || _t[TWEEN.DELAY] > 0)
			{
				_data = _t[TWEEN.PROPERTY_DATA_RAW];
				
				var _propCount = array_length(_data) div 3;
				
				if (_propCount == 1)
				{
					return _data[2];
				}

				var _ret = array_create(_propCount);
				var i = -1;
				var _iData = 1;
				repeat(_propCount)
				{
					_ret[++i] = _data[_iData];
					_iData += 3;	
				}
					
				return _ret;
			}
			
			if (_data[0] == 1)
			{
				return _data[2];	
			}
			else
			{
				var _count = _data[0];
				var _return = array_create(_count);
				var _iData = 2;
				var i = -1;
				repeat(_count)
				{
					_return[++i] = _data[_iData];
					_iData += 4;
				}
				
				return _return;
			}
	    break;
		
		case TWEEN.RAW_START:
			_data = _t[TWEEN.PROPERTY_DATA_RAW];
				
			var _propCount = array_length(_data) div 3;
				
			if (_propCount == 1)
			{
				return _data[2];
			}

			var _ret = array_create(_propCount);
			var i = -1;
			var _iData = 1;
			repeat(_propCount)
			{
				_ret[++i] = _data[_iData];
				_iData += 3;	
			}
					
			return _ret;
		break;
		
		case TWEEN.RAW_DESTINATION:
			_data = _t[TWEEN.PROPERTY_DATA_RAW];
				
			var _propCount = array_length(_data) div 3;
				
			if (_propCount == 1)
			{
				return _data[2];
			}

			var _ret = array_create(_propCount);
			var i = -1;
			var _iData = 2;
			repeat(_propCount)
			{
				_ret[++i] = _data[_iData];
				_iData += 3;
					
			}
					
			return _ret;
		break;
    
	    case TWEEN.DELAY: return _t[TWEEN.DELAY] <= 0 ? 0 : _t[TWEEN.DELAY]; break;
	    case TWEEN.SCALE: return _t[TWEEN.SCALE] * _t[TWEEN.DIRECTION]; break;
		case TWEEN.TIME:  return clamp(_t[TWEEN.TIME], 0, _t[TWEEN.DURATION]); break;
		default:		  return _t[global.TGMS.TweenDataLabelMap[? _dataLabel]];
	}
}


function TweenSet(_t, _dataLabel, _value) 
{	/// @func	TweenSet(tween[s], "dataLabel", value, ...)
	/// @desc	Sets data type for selected tween[s]

	/// tween[s]		tween id[s]
	/// "dataLabel"		data "label" string -- see supported list below
	/// value			value to apply to set data type
	///  ...			(optional) additional values for modifying multi-property tweens

	/*
	    Supported Data Labels:
	        "group"				-- Assign tween to a group
	        "time"				-- Current time of tween in steps or seconds
	        "amount"			-- Sets the tween's time by a relative amount between 0.0 and 1.0 // Change to position?
	        "scale"				-- How fast a tween updates : Default = 1.0
	        "duration"			-- How long a tween takes to fully animate in steps or seconds
	        "ease"				-- The easing algorithm used by the tween
	        "mode"				-- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
	        "target"			-- Target instance associated with tween
	        "delta"				-- Toggle timing between seconds(true) and steps(false)
	        "delay"				-- Current timer of active delay
	        "delay_start"		-- The starting duration for a delay timer
	        "rest"				-- Amount of time rest before continuing -- usable for all play modes except "once" (TWEEN_MODE_ONCE)
			"start"				-- Start value of the property or properties
	        "destination"		-- Destination value of the property or properties
			"raw_start"			-- Update raw start value (before being processed ... e.g. "@+10")
			"raw_destination"	-- Update raw destination value (before being processed ... e.g. "@+10")
	        "property"			-- Property or properties effected by the tween
        
	        e.g.
	            tween = Tween(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            TweenSet(tween, "duration", 2.5);
            
	    The following labels can update multiple properties by supplying
		values in the same order the properties were first assigned:
        
	        "start"
	        "destination"
	        "property"
			"raw_start"
			"raw_destination"
        
	        e.g.
	            tween = Tween(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100); // multi-property tween (x/y)
	            TweenSet(tween, "start", [mouse_x, mouse_y]); // update to x/y mouse coordinates
           
	    The keyword [undefined] can be used to leave a property value unchanged
	        e.g.
	            TweenSet(tween, "start", [undefined, mouse_y]); // update "y" but leave "x" unchanged
	*/

	_t = TGMS_FetchTween(_t);
	
	var _setValue;
	
	var _pIndex = 1;
	while(_pIndex < argument_count)
	{
		_dataLabel = TGMS_StringStrip(argument[_pIndex++], 0);
		var _index = global.TGMS.TweenDataLabelMap[? _dataLabel];
		
		if (_index == undefined)
		{
			if (is_string(_dataLabel))
			{
				if (string_length(_dataLabel) > 1 && global.TGMS.ShorthandTable[string_byte_at(_dataLabel, 1)])
				{
					_index = global.TGMS.TweenDataLabelMap[? string_copy(_dataLabel, 1, 1)];
					
					if (_index == TWEEN.EASE)
					{
						_setValue = global.TGMS.ShortCodesEase[? TGMS_StringStrip(_dataLabel, 0)];
						
						if (_setValue == undefined)
						{
							show_message("TweenGMS: Invalid ease type used in TweenSet()");	
						}
					}
					else
					if (_index == TWEEN.MODE)
					{
						_setValue = global.TGMS.ShortCodesMode[? TGMS_StringStrip(_dataLabel, 0)];
						
						if (_setValue == undefined)
						{
							show_message("TweenGMS: Invalid play mode used in TweenSet()");	
						}
					}
					else
					{
						_setValue = real(string_copy(_dataLabel, 2, 100));
					}
				}
				else
				{
					show_message("TweenGMS: Invalid label used with TweenSet()");
				}
			}
		}
		else
		{
			_setValue = argument[_pIndex++];
		}

		if (is_array(_t))
		{   
		    switch(_index)
		    {
		        case TWEEN.SCALE:
		            _t[@ TWEEN.SCALE] = _setValue * _t[TWEEN.DIRECTION];
		        break;
        
				// THIS IS ON PURPOSE! DON'T WORRY!
				case TWEEN.AMOUNT: _t[@ TWEEN.TIME] = _setValue * _t[TWEEN.DURATION];
		        case TWEEN.TIME: 
		            _t[@ _index] = _setValue; // THIS IS ON PURPOSE! Maybe I should separate these two cases for better clarity
			
					if (_t[TWEEN.STATE] >= 0 && _t[TWEEN.DURATION] != 0)
				    {
						TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
				    }
		        break;
			
				case TWEEN.EASE:
					if (is_real(_setValue))
					{	
						if (_setValue < 100000) 
						{	// Animation Curve ID
							_setValue = animcurve_get_channel(_setValue, 0);
						}
						else 
						{	// Function
							_setValue = method(undefined, _setValue);
						}
					}
					else // "ease" string
					if (is_string(_setValue))
		    		{
						_setValue =  global.TGMS.ShortCodesEase[? TGMS_StringStrip(_setValue, 0)];
		    		}
		    		
		    		// Update ease data
		    		_t[@ TWEEN.EASE] = _setValue;
			
					// Process tween right away if it is currently active and has a valid duration
					if (_t[TWEEN.STATE] >= 0 && _t[TWEEN.DURATION] != 0)
				    {
						TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
				    }
				break;
         
		        case TWEEN.DELAY:
		            if (_t[TWEEN.DELAY] > 0)
		            {
		                _t[@ TWEEN.DELAY] = _setValue;
		            }
		        break;
        
				// TODO: Extend this to support "string" properties which also updates PROPERTY_DATA_RAW
				// Change to pass array
		        case TWEEN.START: // TODO... this might be redundant with if/else check
		        {
		        	if (_t[TWEEN.STATE] != TWEEN_STATE.DELAYED && _t[TWEEN.STATE] != TWEEN_STATE.STOPPED)
		        	{
						// ==== UPDATE LIVE VALUES ====
						var _data = _t[TWEEN.PROPERTY_DATA];

						// Multiple properties
						if (is_array(_setValue))
						{
							var i = -1;
							var _iData = 2;
							repeat(array_length(_setValue))
							{	// Update start
								var _newStart = _setValue[++i];
								if (_newStart != undefined)
								{	// Update change
									_data[@ _iData+1] = _data[_iData] + _data[_iData+1] - _newStart;
									// Update new start
									_data[@ _iData] = _newStart;   
								}
								_iData += 4;
							}
						}
						else // Single property
						{	// Udpate change (destination - start)
							_data[@ 3] = _data[2] + _data[3] - _setValue;
							// Update start
							_data[@ 2] = _setValue;
						}
		        	}

					// ==== UPDATE RAW VALUES ====
		        	var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue))
					{
						var i = -1;
						var _iData = 1;
						repeat(array_length(_setValue))
						{	// Update start
							var _newStart = _setValue[++i];
							if (_newStart != undefined)
							{
								_data[@ _iData] = _newStart;
							}
							_iData += 3;
						}
					}
					else // Single property
					{	// Update start
						_data[@ 1] = _setValue;
					}
		        }
		        break;
        
	        	// TODO: Extend this to support "string" properties which also updates PROPERTY_DATA_RAW
		        case TWEEN.DESTINATION:
		        {
		        	if (_t[TWEEN.STATE] != TWEEN_STATE.DELAYED && _t[TWEEN.STATE] != TWEEN_STATE.STOPPED)
		        	{
						// ==== UPDATE LIVE VALUES ====
						var _data = _t[TWEEN.PROPERTY_DATA];
					
						// Multiple properties
						if (is_array(_setValue)) 
						{
							var i = -1;
							var _iData = 2;
							repeat(array_length(_setValue))
							{	// Update change (destination - start)
								var _newDest = _setValue[++i];
								if (_newDest != undefined)
								{
									_data[@ _iData+1] = _newDest - _data[_iData];   
								}
								_iData += 4;
							}
						}
						else // Single property
						{	// Udpate change (destination - start)
							_data[@ 3] = _setValue - _data[2];
						}
		        	}
	
					// ==== UPDATE RAW VALUES ====
					var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue)) 
					{
						var i = -1;
						var _iData = 2;
						repeat(array_length(_setValue))
						{	// Update raw destination
							var _newDest = _setValue[++i];
							if (_newDest != undefined)
							{
								_data[@ _iData] = _newDest;   
							}
							_iData += 3;
						}
					}
					else // Single property
					{
						_data[@ 2] = _setValue;
					}
		        }
		        break;
        
	        	// TODO: Extend to support struct targets
		        case TWEEN.TARGET:
		            if (is_struct(_t[TWEEN.TARGET]) || _t[TWEEN.TARGET] != noone)
		            {
		            	_t[@ TWEEN.TARGET] = (is_real(_setValue)) ? _setValue.id : weak_ref_create(_setValue);
                
		                if (_t[TWEEN.STATE] >= 0)
		                {
		                    _t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // set active state
		                }
		            }
		        break;
			
				case TWEEN.GROUP:
					_t[@ TWEEN.GROUP] = _setValue;
				
					if (!ds_map_exists(global.TGMS.GroupScales, _t[TWEEN.GROUP]))
					{
						global.TGMS.GroupScales[? _t[TWEEN.GROUP]] = 1;	
					}
				break;
			
		       // prop, start, change, data ----- live
			   // prop, start, dest ---- raw
			   
		        case TWEEN.PROPERTY:
		            var _data = _t[TWEEN.PROPERTY_DATA];
					var _dataRaw = _t[TWEEN.PROPERTY_DATA_RAW];
		            var _argIndex = 0;
                
					if (is_array(_setValue))
					{
						var _argIndex = -1;
						var _dataIndexLive = -3;
						var _dataIndexRaw = -3;
						
						repeat(array_length(_setValue))
			            {
							var _property = _setValue[++_argIndex];
							_dataIndexLive += 4;
							_dataIndexRaw += 3;
                    
			                if (!is_undefined(_property))
			                {
			                    if (is_array(_property)) // Extended Property
			                    {   
			                        _data[@ _dataIndexLive] = _property[0]; // script
			                        _data[@ _dataIndexLive+3] = _property[1]; // data
			                    }
			                    else
								if (is_array(_data))
			                    {	// Get raw property setter script
			                        var _propRaw = global.TGMS.PropertySetters[? _property];
			                        _data[@ _dataIndexLive] = _propRaw; // script
			                        _data[@ _dataIndexLive+3] = _propRaw; // data
			                    }  
								
								// Update raw property
								_dataRaw[@ _dataIndexRaw] = _property; 
			                }
			            }
					}
					else
					{
						var _property = _setValue;
                    
			            if (is_array(_property)) // Extended Property
			            {   
			                _data[@ 1] = _property[0]; // script
			                _data[@ 4] = _property[1]; // data
			            }
			            else
						if (is_array(_data))
			            {	// Get raw property setter script
			                var _propRaw = global.TGMS.PropertySetters[? _property];
			                _data[@ 1] = _propRaw; // script
			                _data[@ 4] = _propRaw; // data
			            }  
						
						// Update raw property
						_dataRaw[@ 0] = _property; 
					}
		        break;
				
				case TWEEN.RAW_START:
					// ==== UPDATE RAW VALUES ====
		        	var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue))
					{
						var i = -1;
						var _iData = 1;
						repeat(array_length(_setValue))
						{	// Update start
							var _newStart = _setValue[++i];
							if (_newStart != undefined)
							{
								_data[@ _iData] = _newStart;
							}
							_iData += 3;
						}
					}
					else // Single property
					{	// Update start
						_data[@ 1] = _setValue;
					}
				break;
				
				case TWEEN.RAW_DESTINATION:
					// ==== UPDATE RAW VALUES ====
					var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue)) 
					{
						var i = -1;
						var _iData = 2;
						repeat(array_length(_setValue))
						{	// Update raw destination
							var _newDest = _setValue[++i];
							if (_newDest != undefined)
							{
								_data[@ _iData] = _newDest;   
							}
							_iData += 3;
						}
					}
					else // Single property
					{
						_data[@ 2] = _setValue;
					}
				break;
		        
				// Default Setter Case
		        default: _t[@ _index] = _setValue;
		    }
		}

		// HANDLE MULTI-TWEEN SETTING
		if (is_struct(_t))
		{
			var _args = array_create(argument_count+1);
			_args[0] = _t;
			_args[1] = TweenSet;
			_args[2] = _index;
			_args[3] = _setValue;
		
			var i = 3;
			repeat(argument_count-3)
			{
				++i;
				_args[i] = argument[i-1]; 
			}
		
			script_execute_ext(TGMS_TweensExecute, _args);
		}
	}
}



