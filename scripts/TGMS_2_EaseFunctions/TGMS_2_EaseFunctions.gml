
//	It is safe to delete:
//		Ease
//		EaseToString


// Make sure TGMS is intialized
TGMS_Begin();


//function CurveUseMagnitude(curve)
//{
//	if (is_real(curve))
//	{
//		curve = animcurve_get(curve);
//	}

//	if (curve[$ "channels"] != undefined)
//	{
//		curve = animcurve_get_channel(curve, 0);
//	}
	
//	curve.tgms_use_magnitude = true;
//}


// TODO: Look into this... "solo" eases
//function EaseSpring(time, start, change, duration)
//{	
//	// base = start
//	// variance = start + change (destination)
//	/*
//		Minus half the variance max from the start,
//		then add half the variance multiplied by the evaluated value
	
//		base = 1;
//		variance = 1.5;
//		TweenFire("$60", "~Spring", "image_scale", base, variance);
	
//	*/

//	//change += start; // get magnitude
	
//	return start + change * animcurve_channel_evaluate(animcurve_get_channel(ac_Spring, 0), time/duration);
//}


function Ease(value1, value2, amount, ease) 
{	/// @desc Interpolates two values by a given amount using specified ease algorithm
	/*
	value1		start value
	value2		end value
	amount		(0-1) amount to interpolate values
	ease			ease algorithm function
	
	Example:
	    x = Ease(x, mouse_x, 0.5, EaseInOutQuad);
	*/

	if (is_real(ease))
	{
		if (ease < 100000) // Animation Curve ID
		{
			return value1+(value2-value1)*animcurve_channel_evaluate(animcurve_get_channel(ease, 0), amount);
		}
		else // Function ID
		{
			return script_execute(ease, amount, value1, value2-value1, 1);
		}
	}

	// Method
	if (is_method(ease))
	{
		return ease(amount, value1, value2-value1, 1);
	}
	
	// Animation Curve Channel
	return value1+(value2-value1)*animcurve_channel_evaluate(ease, amount);
}

function EaseToString(name, ease)
{	/// @func EaseToString(name, ease|curve|channel, [channel])
	SharedTweener();

	if (is_real(ease))
	{
		if (ease < 100000)
		{
			ease = animcurve_get_channel(animcurve_get(ease), argument_count == 3 ? argument[2] : 0);
		}
		else
		{
			ease = method(undefined, ease);	
		}
	}
	
	name = TGMS_StringStrip(name, 0);
	global.TGMS.ShortCodesEase[? name] = ease;
	global.TGMS.ShortCodesEase[? "~"+name] = ease;
}

function EaseToCurve(ease)
{	/// @func EaseToCurve(ease, [num_points])
	var _numPoints = argument_count == 2 ? argument[1] : 180;	
	var _points = array_create(_numPoints+1);
	var i = -1;
	repeat(_numPoints+1)
	{
		var _time = ++i/_numPoints;
		_points[i] = animcurve_point_new();
		_points[i].posx = _time;
		_points[i].value = ease(_time, 0, 1, 1);
	}

	var _channel = animcurve_channel_new();
	_channel.type = animcurvetype_linear;
	_channel.iterations = 1;
	_channel.points = _points;
	
	return _channel;
}







//=============================
// PENNER'S EASING ALGORITHMS
//=============================
/*
	Terms of Use: Easing Functions (Equations)
	Open source under the MIT License and the 3-Clause BSD License.

	MIT License
	Copyright © 2001 Robert Penner

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

	BSD License
	Copyright © 2001 Robert Penner

	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// LINEAR
function EaseLinear(time, start, change, duration)
{	
	return change * time / duration + start;
}

// QUAD
function EaseInQuad(time, start, change, duration)
{	
	return change * time/duration * time/duration + start;
}

function EaseOutQuad(time, start, change, duration)
{
	return -change * time/duration * (time/duration-2) + start;
}

function EaseInOutQuad(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * time * time + start
					: change * -0.5 * ((time-1) * (time - 3) - 1) + start;
}

// CUBIC
function EaseInCubic(time, start, change, duration)
{
	return change * power(time/duration, 3) + start;
}

function EaseOutCubic(time, start, change, duration)
{
	return change * (power(time/duration - 1, 3) + 1) + start;
}

function EaseInOutCubic(time, start, change, duration)
{
	time = 2 * time / duration;
	return time < 1 ? change * 0.5 * power(time, 3) + start
					: change * 0.5 * (power(time-2, 3) + 2) + start;
}

// QUART
function EaseInQuart(time, start, change, duration)
{
	return change * power(time/duration, 4) + start;
}

function EaseOutQuart(time, start, change, duration)
{
	return -change * (power(time/duration - 1, 4) - 1) + start;
}

function EaseInOutQuart(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * power(time, 4) + start
					: change * -0.5 * (power(time - 2, 4) - 2) + start;
}

// QUINT
function EaseInQuint(time, start, change, duration)
{
	return change * power(time/duration, 5) + start;
}

function EaseOutQuint(time, start, change, duration)
{
	return change * (power(time/duration - 1, 5) + 1) + start;
}

function EaseInOutQuint(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * power(time, 5) + start
					: change * 0.5 * (power(time - 2, 5) + 2) + start;
}

// SINE
function EaseInSine(time, start, change, duration)
{
	return change * (1 - cos(time/duration * (pi/2))) + start;
}

function EaseOutSine(time, start, change, duration)
{
	return change * sin(time/duration * (pi/2)) + start;
}

function EaseInOutSine(time, start, change, duration)
{
	return change * 0.5 * (1 - cos(pi*time/duration)) + start;
}

// CIRC
function EaseInCirc(time, start, change, duration)
{
	return change * (1 - sqrt(1 - time/duration * time/duration)) + start;
}

function EaseOutCirc(time, start, change, duration)
{
	time = time/duration - 1;
	return change * sqrt(abs(1 - time * time)) + start;
}

function EaseInOutCirc(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * (1 - sqrt(abs(1 - time * time))) + start
					: change * 0.5 * (sqrt(abs(1 - (time-2) * (time-2))) + 1) + start;
}

// EXPO
function EaseInExpo(time, start, change, duration)
{
	return change * power(2, 10 * (time/duration - 1)) + start;
}

function EaseOutExpo(time, start, change, duration)
{
	return change * (-power(2, -10 * time / duration) + 1) + start;
}

function EaseInOutExpo(time, start, change, duration)
{
	time = 2 * time / duration;
	return time < 1 ? change * 0.5 * power(2, 10 * (time-1)) + start
					: change * 0.5 * (-power(2, -10 * (time-1)) + 2) + start;
}
	
// BACK
function EaseInBack(time, start, change, duration)
{
	time /= duration;
	duration = 1.70158; // repurpose duration as Penner's "s" value -- You can hardcode this into wherever you see 'duration' in the next line
	return change * time * time * ((duration + 1) * time - duration) + start;
}
	
function EaseOutBack(time, start, change, duration)
{
	time = time/duration - 1;
	duration = 1.70158; // "s"
	return change * (time * time * ((duration + 1) * time + duration) + 1) + start;
}	
	
function EaseInOutBack(time, start, change, duration)
{
	time = time/duration*2;
	duration = 1.70158; // "s"

	if (time < 1)
	{
	    duration *= 1.525;
	    return change * 0.5 * (((duration + 1) * time - duration) * time * time) + start;
	}

	time -= 2;
	duration *= 1.525;

	return change * 0.5 * (((duration + 1) * time + duration) * time * time + 2) + start;
}

// BOUNCE
function EaseInBounce(time, start, change, duration)
{
	return change - EaseOutBounce(duration - time, 0, change, duration) + start;
}
	
function EaseOutBounce(time, start, change, duration)
{
	time /= duration;

	if (time < 1/2.75)
	{
	    return change * 7.5625 * time * time + start;
	}
	else
	if (time < 2/2.75)
	{
	    time -= 1.5/2.75;
	    return change * (7.5625 * time * time + 0.75) + start;
	}
	else
	if (time < 2.5/2.75)
	{
	    time -= 2.25/2.75;
	    return change * (7.5625 * time * time + 0.9375) + start;
	}
	else
	{
	    time -= 2.625/2.75;
	    return change * (7.5625 * time * time + 0.984375) + start;
	}
}
	
function EaseInOutBounce(time, start, change, duration)
{
	return time < duration*0.5 ? EaseInBounce(time*2, 0, change, duration)*0.5 + start
							   : EaseOutBounce(time*2 - duration, 0, change, duration)*0.5 + change*0.5 + start;
}
	
// ELASTIC
function EaseInElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = 0;
	var _val = 0;
	
	_a = change;
	_val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration;

	if (_val == 1) { return start+change; }

	if (_p == 0) { _p = duration*0.3; }

	if (_a < abs(change)) 
	{ 
	    _a = change; // lol, wut?
	    _s = _p*0.25; 
	}
	else
	{
	    _s = _p / (2*pi) * arcsin(change/_a);
	}

	return -(_a * power(2,10 * (_val-1)) * sin(((_val-1) * duration - _s) * (2*pi) / _p)) + start;
}
	
function EaseOutElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = 0;
	var _val = 0;
	
	_a = change;
	_val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration;

	if (_val == 1) { return start + change; }

	if (_p == 0) { _p = duration * 0.3; }

	if (_a < abs(change)) 
	{ 
	    _a = change; // lol, wut?
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2*pi) * arcsin (change/_a);
	}

	return _a * power(2, -10 * _val) * sin((_val * duration - _s) * (2*pi) / _p ) + change + start;
}

function EaseInOutElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = 0;
	var _val = 0;
	
	_a = change;
	_val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration*0.5;

	if (_val == 2) { return start+change; }

	if (_p == 0) { _p = duration * (0.3 * 1.5); }

	if (_a < abs(change)) 
	{ 
	    _a = change;
	    _s = _p * 0.25;
	}
	else
	{
	    _s = _p / (2*pi) * arcsin (change / _a);
	}

	if (_val < 1) { return -0.5 * (_a * power(2, 10 * (_val-1)) * sin(((_val-1) * duration - _s) * (2*pi) / _p)) + start; }

	return _a * power(2, -10 * (_val-1)) * sin(((_val-1) * duration - _s) * (2*pi) / _p) * 0.5 + change + start;
}

//----------------------------------
// Convert Ease Functions to Curves
//----------------------------------
#macro EaseNone global.TGMS.CurveLinear_ // Keep for backwards compat
#macro CurveLinear global.TGMS.CurveLinear_
global.TGMS.CurveLinear_ = EaseToCurve(EaseLinear, 1);

#macro CurveInQuad global.TGMS.CurveInQuad_
#macro CurveOutQuad global.TGMS.CurveOutQuad_
#macro CurveInOutQuad global.TGMS.CurveInOutQuad_
global.TGMS.CurveInQuad_    = EaseToCurve(EaseInQuad);			
global.TGMS.CurveOutQuad_   = EaseToCurve(EaseOutQuad);			
global.TGMS.CurveInOutQuad_ = EaseToCurve(EaseInOutQuad);	

#macro CurveInCubic global.TGMS.CurveInCubic_
#macro CurveOutCubic global.TGMS.CurveOutCubic_
#macro CurveInOutCubic global.TGMS.CurveInOutCubic_
global.TGMS.CurveInCubic_    = EaseToCurve(EaseInCubic);		
global.TGMS.CurveOutCubic_   = EaseToCurve(EaseOutCubic);		
global.TGMS.CurveInOutCubic_ = EaseToCurve(EaseInOutCubic);	

#macro CurveInQuart global.TGMS.CurveInQuart_
#macro CurveOutQuart global.TGMS.CurveOutQuart_
#macro CurveInOutQuart global.TGMS.CurveInOutQuart_
global.TGMS.CurveInQuart_    = EaseToCurve(EaseInQuart);		
global.TGMS.CurveOutQuart_   = EaseToCurve(EaseOutQuart);		
global.TGMS.CurveInOutQuart_ = EaseToCurve(EaseInOutQuart);	

#macro CurveInQuint global.TGMS.CurveInQuint_
#macro CurveOutQuint global.TGMS.CurveOutQuint_
#macro CurveInOutQuint global.TGMS.CurveInOutQuint_
global.TGMS.CurveInQuint_    = EaseToCurve(EaseInQuint);		
global.TGMS.CurveOutQuint_   = EaseToCurve(EaseOutQuint);		
global.TGMS.CurveInOutQuint_ = EaseToCurve(EaseInOutQuint);	

#macro CurveInSine global.TGMS.CurveInSine_
#macro CurveOutSine global.TGMS.CurveOutSine_
#macro CurveInOutSine global.TGMS.CurveInOutSine_
global.TGMS.CurveInSine_    = EaseToCurve(EaseInSine);			
global.TGMS.CurveOutSine_   = EaseToCurve(EaseOutSine);			
global.TGMS.CurveInOutSine_ = EaseToCurve(EaseInOutSine);	

#macro CurveInCirc global.TGMS.CurveInCirc_
#macro CurveOutCirc global.TGMS.CurveOutCirc_
#macro CurveInOutCirc global.TGMS.CurveInOutCirc_
global.TGMS.CurveInCirc_    = EaseToCurve(EaseInCirc);			
global.TGMS.CurveOutCirc_   = EaseToCurve(EaseOutCirc);			
global.TGMS.CurveInOutCirc_ = EaseToCurve(EaseInOutCirc);	

#macro CurveInExpo global.TGMS.CurveInExpo_
#macro CurveOutExpo global.TGMS.CurveOutExpo_
#macro CurveInOutExpo global.TGMS.CurveInOutExpo_
global.TGMS.CurveInExpo_    = EaseToCurve(EaseInExpo);			
global.TGMS.CurveOutExpo_   = EaseToCurve(EaseOutExpo);			
global.TGMS.CurveInOutExpo_ = EaseToCurve(EaseInOutExpo);	

#macro CurveInBack global.TGMS.CurveInBack_
#macro CurveOutBack global.TGMS.CurveOutBack_
#macro CurveInOutBack global.TGMS.CurveInOutBack_
global.TGMS.CurveInBack_       = EaseToCurve(EaseInBack);		
global.TGMS.CurveOutBack_      = EaseToCurve(EaseOutBack);		
global.TGMS.CurveInOutBack_    = EaseToCurve(EaseInOutBack);	

#macro CurveInBounce global.TGMS.CurveInBounce_
#macro CurveOutBounce global.TGMS.CurveOutBounce_
#macro CurveInOutBounce global.TGMS.CurveInOutBounce_
global.TGMS.CurveInBounce_     = EaseToCurve(EaseInBounce);		
global.TGMS.CurveOutBounce_    = EaseToCurve(EaseOutBounce);	
global.TGMS.CurveInOutBounce_  = EaseToCurve(EaseInOutBounce);	

#macro CurveInElastic global.TGMS.CurveInElastic_
#macro CurveOutElastic global.TGMS.CurveOutElastic_
#macro CurveInOutElastic global.TGMS.CurveInOutElastic_
global.TGMS.CurveInElastic_    = EaseToCurve(EaseInElastic);	
global.TGMS.CurveOutElastic_   = EaseToCurve(EaseOutElastic);	
global.TGMS.CurveInOutElastic_ = EaseToCurve(EaseInOutElastic);	
			

//======================
// EASING "SHORT CODES"
//======================
global.TGMS.ShortCodesEase = ds_map_create();
_= global.TGMS.ShortCodesEase;
	
_[? ""] = CurveLinear;
_[? "none"] = CurveLinear;

// Default 
_[? "~in"] = CurveInSine;				_[? "in"] = CurveInSine;
_[? "~out"] = CurveOutSine;				_[? "out"] = CurveOutSine;
_[? "~inout"] = CurveInOutSine;			_[? "inout"] = CurveInOutSine;
_[? "~i"] = CurveInSine;				_[? "i"] = CurveInSine;
_[? "~o"] = CurveOutSine;				_[? "o"] = CurveOutSine;
_[? "~io"] = CurveInOutSine;			_[? "io"] = CurveInOutSine;
	
// Linear
_[? "~linear"] = CurveLinear;			_[? "linear"] = CurveLinear;
// Quad
_[? "~inquad"] = CurveInQuad;			_[? "inquad"] = CurveInQuad;
_[? "~outquad"] = CurveOutQuad;			_[? "outquad"] = CurveOutQuad;
_[? "~inoutquad"] = CurveInOutQuad;		_[? "inoutquad"] = CurveInOutQuad;
_[? "~iquad"] = CurveInQuad;			_[? "iquad"] = CurveInQuad;
_[? "~oquad"] = CurveOutQuad;			_[? "oquad"] = CurveOutQuad;
_[? "~ioquad"] = CurveInOutQuad;		_[? "ioquad"] = CurveInOutQuad;
// Cubic
_[? "~incubic"] = CurveInCubic;			_[? "incubic"] = CurveInCubic;
_[? "~outcubic"] = CurveOutCubic;		_[? "outcubic"] = CurveOutCubic;
_[? "~inoutcubic"] = CurveInOutCubic;	_[? "inoutcubic"] = CurveInOutCubic;
_[? "~icubic"] = CurveInCubic;			_[? "icubic"] = CurveInCubic;
_[? "~ocubic"] = CurveOutCubic;			_[? "ocubic"] = CurveOutCubic;			
_[? "~iocubic"] = CurveInOutCubic;		_[? "iocubic"] = CurveInOutCubic;
// Quart
_[? "~inquart"] = CurveInQuart;			_[? "inquart"] = CurveInQuart;
_[? "~outquart"] = CurveOutQuart;		_[? "outquart"] = CurveOutQuart;
_[? "~inoutquart"] = CurveInOutQuart;	_[? "inoutquart"] = CurveInOutQuart;
_[? "~iquart"] = CurveInQuart;			_[? "iquart"] = CurveInQuart;
_[? "~oquart"] = CurveOutQuart;			_[? "oquart"] = CurveOutQuart;
_[? "~ioquart"] = CurveInOutQuart;		_[? "ioquart"] = CurveInOutQuart;
// Quint
_[? "~inquint"] = CurveInQuint;			_[? "inquint"] = CurveInQuint;
_[? "~outquint"] = CurveOutQuint;		_[? "outquint"] = CurveOutQuint;
_[? "~inoutquint"] = CurveInOutQuint;	_[? "inoutquint"] = CurveInOutQuint;
_[? "~iquint"] = CurveInQuint;			_[? "iquint"] = CurveInQuint;
_[? "~oquint"] = CurveOutQuint;			_[? "oquint"] = CurveOutQuint;
_[? "~ioquint"] = CurveInOutQuint;		_[? "ioquint"] = CurveInOutQuint;
// Sine
_[? "~insine"] = CurveInSine;			_[? "insine"] = CurveInSine;
_[? "~outsine"] = CurveOutSine;			_[? "outsine"] = CurveOutSine;
_[? "~inoutsine"] = CurveInOutSine;		_[? "inoutsine"] = CurveInOutSine;
_[? "~isine"] = CurveInSine;			_[? "isine"] = CurveInSine;
_[? "~osine"] = CurveOutSine;			_[? "osine"] = CurveOutSine;
_[? "~iosine"] = CurveInOutSine;		_[? "iosine"] = CurveInOutSine;
// Circ
_[? "~incirc"] = CurveInCirc;			_[? "incirc"] = CurveInCirc;
_[? "~outcirc"] = CurveOutCirc;			_[? "outcirc"] = CurveOutCirc;
_[? "~inoutcirc"] = CurveInOutCirc;		_[? "inoutcirc"] = CurveInOutCirc;
_[? "~icirc"] = CurveInCirc;			_[? "icirc"] = CurveInCirc;
_[? "~ocirc"] = CurveOutCirc;			_[? "ocirc"] = CurveOutCirc;
_[? "~iocirc"] = CurveInOutCirc;		_[? "iocirc"] = CurveInOutCirc;
// Expo
_[? "~inexpo"] = CurveInExpo;			_[? "inexpo"] = CurveInExpo;
_[? "~outexpo"] = CurveOutExpo;			_[? "outexpo"] = CurveOutExpo;
_[? "~inoutexpo"] = CurveInOutExpo;		_[? "inoutexpo"] = CurveInOutExpo;
_[? "~iexpo"] = CurveInExpo;			_[? "iexpo"] = CurveInExpo;
_[? "~oexpo"] = CurveOutExpo;			_[? "oexpo"] = CurveOutExpo;
_[? "~ioexpo"] = CurveInOutExpo;		_[? "ioexpo"] = CurveInOutExpo;
// Elastic
_[? "~inelastic"] = CurveInElastic;			_[? "inelastic"] = CurveInElastic;
_[? "~outelastic"] = CurveOutElastic;		_[? "outelastic"] = CurveOutElastic;
_[? "~inoutelastic"] = CurveInOutElastic;	_[? "inoutelastic"] = CurveInOutElastic;
_[? "~ielastic"] = CurveInElastic;			_[? "ielastic"] = CurveInElastic;
_[? "~oelastic"] = CurveOutElastic;			_[? "oelastic"] = CurveOutElastic;
_[? "~ioelastic"] = CurveInOutElastic;		_[? "ioelastic"] = CurveInOutElastic;
// Back
_[? "~inback"] = CurveInBack;				_[? "inback"] = CurveInBack;
_[? "~outback"] = CurveOutBack;				_[? "outback"] = CurveOutBack;
_[? "~inoutback"] = CurveInOutBack;			_[? "inoutback"] = CurveInOutBack;
_[? "~iback"] = CurveInBack;				_[? "iback"] = CurveInBack;
_[? "~oback"] = CurveOutBack;				_[? "oback"] = CurveOutBack;
_[? "~ioback"] = CurveInOutBack;			_[? "ioback"] = CurveInOutBack;
// Bounce
_[? "~inbounce"] = CurveInBounce;			_[? "inbounce"] = CurveInBounce;
_[? "~outbounce"] = CurveOutBounce;			_[? "outbounce"] = CurveOutBounce;
_[? "~inoutbounce"] = CurveInOutBounce;		_[? "inoutbounce"] = CurveInOutBounce;
_[? "~ibounce"] = CurveInBounce;			_[? "ibounce"] = CurveInBounce;
_[? "~obounce"] = CurveOutBounce;			_[? "obounce"] = CurveOutBounce;
_[? "~iobounce"] = CurveInOutBounce;		_[? "iobounce"] = CurveInOutBounce;











