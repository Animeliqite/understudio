

// DEPRECATED FUNCTIONS //

// Please use TweenAddCallback() which now supports user events directly.
// e.g. TweenAddCallback(tween, "finish", self, 5); // Call user event 5

function TweenAddCallbackUser(_tweenID, _event, _target, _user) 
{	/// @func TweenAddCallbackUser(<deprecated> tween, event, target, user_event)
	TweenAddCallback(_tweenID, _event, _target, event_user, _user);
}


// These 2 functions have been consolidated into TweenCalc() which now takes a second optional argument.
// Passing a second argument to TweenCalc() as a real number sets the amount, 
// while wrapping the second argument inside an array [value] will calculate an explicit time.

function TweenCalcAmount(tween, amount)
{ /// @func TweenCalcAmount(<deprecated>tween, amount)
	TweenCalc(tween, amount);
}

function TweenCalcTime(tween, amount)
{	/// @func TweenCalcTime(<deprecated>tween, amount)
	TweenCalc(tween, [amount]);
}