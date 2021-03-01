/*
	It is safe to delete any function from this script
	or to delete this whole script entirely
*/


/// @func TweenEasyUseDelta(use_seconds?)
/// @desc Toggle between using step or delta(seconds) timing for "Easy Tweens"
function TweenEasyUseDelta(use_seconds) 
{
	SharedTweener();
	global.TGMS_EasyUseDelta = use_seconds;
}


/// @func TweenEasyMove(x1, y1, x2, y2, delay, duration, ease, *mode)
/// @desc Tween instance's x/y position
function TweenEasyMove(x1, y1, x2, y2, delay, duration, ease) 
{	
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyMove") && TweenExists(__TweenEasyMove))
	{
		TweenDestroy(__TweenEasyMove);
	}

	__TweenEasyMove = TweenFire(id, ease, argument_count == 8 ? argument[7] : 0, global.TGMS_EasyUseDelta, delay, duration, "x", x1, x2, "y", y1, y2);
	return __TweenEasyMove;
}


/// @func TweenEasyScale(x1, y1, x2, y2, delay, duration, ease, *mode)
/// @desc Tween instance's image scale
function TweenEasyScale(x1, y1, x2, y2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyScale") && TweenExists(__TweenEasyScale))
	{
		TweenDestroy(__TweenEasyScale);
	}

	__TweenEasyScale = TweenFire(id, ease, argument_count == 8 ? argument[7] : 0, global.TGMS_EasyUseDelta, delay, duration, "image_xscale", x1, x2, "image_yscale", y1, y2);
	return __TweenEasyScale;
}

/// @func TweenEasyRotate(angle1, angle2, delay, duration, ease, *mode)
/// @desc Tween instance's image angle
function TweenEasyRotate(angle1, angle2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyRotate") && TweenExists(__TweenEasyRotate))
	{
		TweenDestroy(__TweenEasyRotate);
	}

	__TweenEasyRotate = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, "image_angle", angle1, angle2);
	return __TweenEasyRotate;
}

/// @func TweenEasyFade(alpha1, alpha2, delay, duration, ease, *mode)
/// @desc Tween instance's image alpha
function TweenEasyFade(alpha1, alpha2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyFade") && TweenExists(__TweenEasyFade))
	{
		TweenDestroy(__TweenEasyFade);
	}

	__TweenEasyFade = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, "image_alpha", alpha1, alpha2);
	return __TweenEasyFade;
}

/// @func TweenEasyBlend(col1, col2, delay, duration, ease, *mode)
/// @desc Tween instance's image blend colour
function TweenEasyBlend(col1, col2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyBlend") && TweenExists(__TweenEasyBlend))
	{
		TweenDestroy(__TweenEasyBlend);
	}

	__TweenEasyBlend = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, "image_blend", col1, col2);
	return __TweenEasyBlend;
}

/// @func TweenEasyImage(index1, index2, delay, duration, ease, *mode)
/// @desc Tween instance's image index
function TweenEasyImage(index1, index2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyImage") && TweenExists(__TweenEasyImage))
	{
		TweenDestroy(__TweenEasyImage);
	}

	__TweenEasyImage = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, "image_index", index1, index2);
	return __TweenEasyImage;
}
		
/// @func TweenEasyTurn(dir1, dir2, delay, duration, ease, *mode)
/// @desc Tween instance's direction
function TweenEasyTurn(dir1, dir2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyTurn") && TweenExists(__TweenEasyTurn))
	{
		TweenDestroy(__TweenEasyTurn);
	}

	__TweenEasyTurn = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, "direction", dir1, dir2);
	return __TweenEasyTurn;
}
	
/// @func TweenEasyPath(path, absolute, delay, duration, ease, *mode)
/// @desc Eases instance position using path
function TweenEasyPath(path, absolute, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyPath") && TweenExists(__TweenEasyPath))
	{
		TweenDestroy(__TweenEasyPath);
	}
							
	__TweenEasyPath = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, absolute ? [TPPath, path] : [TPPath, path, x, y], 0, 1);
	return __TweenEasyPath;
}

/// @func TweenEasySpeed(spd1, spd2, delay, duration, ease, *mode)
/// @desc Tween instance's speed
function TweenEasySpeed(spd1, spd2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasySpeed") && TweenExists(__TweenEasySpeed))
	{
		TweenDestroy(__TweenEasySpeed);
	}

	__TweenEasySpeed = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS_EasyUseDelta, delay, duration, "speed", spd1, spd2);
	return __TweenEasySpeed;
}

/// @func TweenEasySpeedHV(hspd1, vspd1, hspd2, vspd2, delay, duration, ease, *mode)
/// @desc Tween instance's hspeed/vspeed
function TweenEasySpeedHV(hspd1, vspd1, hspd2, vspd2, delay, duration, ease) 
{
	SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasySpeedHV") && TweenExists(__TweenEasySpeedHV))
	{
		TweenDestroy(__TweenEasySpeedHV);
	}

	__TweenEasySpeedHV = TweenFire(id, ease, argument_count == 8 ? argument[7] : 0, global.TGMS_EasyUseDelta, delay, duration, "hspeed", hspd1, hspd2, "vspeed", vspd1, vspd2);
	return __TweenEasySpeedHV;
}





