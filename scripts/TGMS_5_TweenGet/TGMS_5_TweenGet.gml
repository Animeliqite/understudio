/*
	It is safe to delete:
		TweenGroupGetTimeScale
		TweensIncludeDeactivated
		TweenGetDefault
*/

///@func TweenGroupGetTimeScale(group)
function TweenGroupGetTimeScale(group)
{
	if (!ds_map_exists(global.TGMS_GroupScales, group))
	{	// Set a default group scale if it doesn't exist
		global.TGMS_GroupScales[? group] = 1.0;
	}
	
	return global.TGMS_GroupScales[? group];	
}


///@func TweensIncludeDeactivated(include?)
///@desc Include tweens with deactivated targets? Used by Tweens() function. Default: false
function TweensIncludeDeactivated(_include) 
{
	global.TGMS_TweensIncludeDeactivated = _include;
}


///@func TweenGetDefault("data_label")
function TweenGetDefault(_dataLabel)
{
	//	Supported Data Labels:
	//		"group" "delta" "scale" "ease" "mode" "duration" "rest" "amount" "continue_count"
	
	return TweenGet(TWEEN_DEFAULT, _dataLabel);
}


///@func TweenGet(tween, "data_label")
function TweenGet(_t, _dataLabel) 
{
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

	switch(global.TGMS_TweenDataLabelMap[? _dataLabel])
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
		default:		  return _t[global.TGMS_TweenDataLabelMap[? _dataLabel]]
	}
}

