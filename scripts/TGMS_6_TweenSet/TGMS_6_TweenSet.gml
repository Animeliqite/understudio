/*
	It is safe to delete:
		TweenGroupSetTimeScale
		TweenSetDefault
*/

/// @func TweenGroupSetTimeScale(group, time_scale);
function TweenGroupSetTimeScale(_group, _timescale)
{
	global.TGMS_GroupScales[? _group] = _timescale;
}


/// @func TweenSetDefault("data_label", _value, ...)
function TweenSetDefault(_dataLabel)
{
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


/// @func	TweenSet(tween[s], "dataLabel", value, ...)
/// @desc	Sets data type for selected tween[s]
function TweenSet(_t, _dataLabel, _value) 
{
	/// @param tween[s]		tween id[s]
	/// @param "dataLabel"	data "label" string -- see supported list below
	/// @param value		value to apply to set data type
	/// @param ...			(optional) additional values for modifying multi-property tweens

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
	
	var _pIndex = -1;
	
	repeat((argument_count-1) div 2)
	{
		_pIndex += 2;
		_dataLabel = argument[_pIndex];
		_value = argument[_pIndex+1];
	
		var _index = global.TGMS_TweenDataLabelMap[? _dataLabel];

		if (is_array(_t))
		{   
		    switch(_index)
		    {
		        case TWEEN.SCALE:
		            _t[@ TWEEN.SCALE] = _value * _t[TWEEN.DIRECTION];
		        break;
        
				// THIS IS ON PURPOSE! DON'T WORRY!
				case TWEEN.AMOUNT: _t[@ TWEEN.TIME] = _value * _t[TWEEN.DURATION];
		        case TWEEN.TIME: 
		            _t[@ _index] = _value; // THIS IS ON PURPOSE! Maybe I should separate these two cases for better clarity
			
					if (_t[TWEEN.STATE] >= 0 && _t[TWEEN.DURATION] != 0)
				    {
						TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
				    }
		        break;
			
				case TWEEN.EASE:
					// Animation Curve ID
					if (is_real(_value))
					{
						_value = animcurve_get_channel(_value, 0);
					}
					else // "ease" string
					if (is_string(_value))
		    		{
						_value =  global.TGMS_ShortCodesEase[? TGMS_StringLower(_value, 0)];
		    		}
		    		
		    		// Update ease data
		    		_t[@ TWEEN.EASE] = _value;
			
					// Process tween right away if it is currently active and has a valid duration
					if (_t[TWEEN.STATE] >= 0 && _t[TWEEN.DURATION] != 0)
				    {
						TGMS_TweenProcess(_t, _t[TWEEN.TIME], _t[TWEEN.PROPERTY_DATA], is_real(_t[TWEEN.TARGET]) ? _t[TWEEN.TARGET] : _t[TWEEN.TARGET].ref);
				    }
				break;
         
		        case TWEEN.DELAY:
		            if (_t[TWEEN.DELAY] > 0)
		            {
		                _t[@ TWEEN.DELAY] = _value;
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
						if (is_array(_value))
						{
							var i = -1;
							var _iData = 2;
							repeat(array_length(_value))
							{	// Update start
								var _newStart = _value[++i];
								if (_newStart != undefined)
								{	// Update change
									_data[@ _iData+1] = _data[_iData] + _data[_iData+1] - _newStart
									// Update new start
									_data[@ _iData] = _newStart;   
								}
								_iData += 4;
							}
						}
						else // Single property
						{	// Udpate change (destination - start)
							_data[@ 3] = _data[2] + _data[3] - _value;
							// Update start
							_data[@ 2] = _value;
						}
		        	}

					// ==== UPDATE RAW VALUES ====
		        	var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_value))
					{
						var i = -1;
						var _iData = 1;
						repeat(array_length(_value))
						{	// Update start
							var _newStart = _value[++i];
							if (_newStart != undefined)
							{
								_data[@ _iData] = _newStart;
							}
							_iData += 3;
						}
					}
					else // Single property
					{	// Update start
						_data[@ 1] = _value;
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
						if (is_array(_value)) 
						{
							var i = -1;
							var _iData = 2;
							repeat(array_length(_value))
							{	// Update change (destination - start)
								var _newDest = _value[++i];
								if (_newDest != undefined)
								{
									_data[@ _iData+1] = _newDest - _data[_iData];   
								}
								_iData += 4;
							}
						}
						else // Single property
						{	// Udpate change (destination - start)
							_data[@ 3] = _value - _data[2];
						}
		        	}
	
					// ==== UPDATE RAW VALUES ====
					var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_value)) 
					{
						var i = -1;
						var _iData = 2;
						repeat(array_length(_value))
						{	// Update raw destination
							var _newDest = _value[++i];
							if (_newDest != undefined)
							{
								_data[@ _iData] = _newDest;   
							}
							_iData += 3;
						}
					}
					else // Single property
					{
						_data[@ 2] = _value;
					}
		        }
		        break;
        
	        	// TODO: Extend to support struct targets
		        case TWEEN.TARGET:
		            if (is_struct(_t[TWEEN.TARGET]) || _t[TWEEN.TARGET] != noone)
		            {
		            	_t[@ TWEEN.TARGET] = (is_real(_value)) ? _value.id : weak_ref_create(_value);
                
		                if (_t[TWEEN.STATE] >= 0)
		                {
		                    _t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // set active state
		                }
		            }
		        break;
			
				case TWEEN.GROUP:
					_t[@ TWEEN.GROUP] = _value;
				
					if (!ds_map_exists(global.TGMS_GroupScales, _t[TWEEN.GROUP]))
					{
						global.TGMS_GroupScales[? _t[TWEEN.GROUP]] = 1;	
					}
				break;
			
		       // prop, start, change, data ----- live
			   // prop, start, dest ---- raw
			   
		        case TWEEN.PROPERTY:
		            var _data = _t[TWEEN.PROPERTY_DATA];
					var _dataRaw = _t[TWEEN.PROPERTY_DATA_RAW];
		            var _argIndex = 0;
                
					if (is_array(_value))
					{
						var _argIndex = -1;
						var _dataIndexLive = -3;
						var _dataIndexRaw = -3;
						
						repeat(array_length(_value))
			            {
							var _property = _value[++_argIndex];
							_dataIndexLive += 4;
							_dataIndexRaw += 3;
                    
			                if (!is_undefined(_property))
			                {
			                    if (is_array(_property)) // Extended Property
			                    {   
			                        _data[@ _dataIndexLive] = _property[0] // script
			                        _data[@ _dataIndexLive+3] = _property[1]; // data
			                    }
			                    else
								if (is_array(_data))
			                    {	// Get raw property setter script
			                        var _propRaw = global.TGMS_PropertySetters[? _property];
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
						var _property = _value;
                    
			            if (is_array(_property)) // Extended Property
			            {   
			                _data[@ 1] = _property[0] // script
			                _data[@ 4] = _property[1]; // data
			            }
			            else
						if (is_array(_data))
			            {	// Get raw property setter script
			                var _propRaw = global.TGMS_PropertySetters[? _property];
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
					if (is_array(_value))
					{
						var i = -1;
						var _iData = 1;
						repeat(array_length(_value))
						{	// Update start
							var _newStart = _value[++i];
							if (_newStart != undefined)
							{
								_data[@ _iData] = _newStart;
							}
							_iData += 3;
						}
					}
					else // Single property
					{	// Update start
						_data[@ 1] = _value;
					}
				break;
				
				case TWEEN.RAW_DESTINATION:
					// ==== UPDATE RAW VALUES ====
					var _data = _t[TWEEN.PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_value)) 
					{
						var i = -1;
						var _iData = 2;
						repeat(array_length(_value))
						{	// Update raw destination
							var _newDest = _value[++i];
							if (_newDest != undefined)
							{
								_data[@ _iData] = _newDest;   
							}
							_iData += 3;
						}
					}
					else // Single property
					{
						_data[@ 2] = _value;
					}
				break;
		        
				// Default Setter Case
		        default: _t[@ _index] = _value;
		    }
		}

		// HANDLE MULTI-TWEEN SETTING
		if (is_struct(_t))
		{
			var _args = array_create(argument_count+1);
			_args[0] = _t;
			_args[1] = TweenSet;
			_args[2] = _index;
			_args[3] = _value;
		
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



