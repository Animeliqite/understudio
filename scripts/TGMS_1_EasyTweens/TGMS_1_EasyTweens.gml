/*
	It is safe to delete any function from this script
	or to delete this whole script entirely
*/


function TweenEasyUseDelta(use_seconds) 
{	/// @desc Toggle between using step or delta(seconds) timing for "Easy Tweens"
	/// @func TweenEasyUseDelta([use_seconds?])
	
	SharedTweener();
	
	if (use_seconds == undefined)
	{
		return global.TGMS.EasyUseDelta;
	}
	
	global.TGMS.EasyUseDelta = use_seconds;
}

function TweenEasyMove(x1, y1, x2, y2, delay, duration, ease) 
{	/// @desc Tween instance's x/y position	
	/// @func TweenEasyMove(x1, y1, x2, y2, delay, duration, ease, mode*)

	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyMove = "__TweenEasyMove";
	static str_x = "x";
	static str_y = "y";
	
	if (variable_instance_exists(id, str_TweenEasyMove) && TweenExists(__TweenEasyMove))
	{
		TweenDestroy(__TweenEasyMove);
	}

	__TweenEasyMove = TweenFire(id, ease, argument_count == 8 ? argument[7] : 0, global.TGMS.EasyUseDelta, delay, duration, str_x, x1, x2, str_y, y1, y2);
	return __TweenEasyMove;
}

function TweenEasyScale(x1, y1, x2, y2, delay, duration, ease) 
{	/// @desc Tween instance's image scale
	/// @func TweenEasyScale(x1, y1, x2, y2, delay, duration, ease, mode*)
	
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyScale = "__TweenEasyScale";
	static str_xscale = "image_xscale";
	static str_yscale = "image_yscale";
	
	if (variable_instance_exists(id, str_TweenEasyScale) && TweenExists(__TweenEasyScale))
	{
		TweenDestroy(__TweenEasyScale);
	}

	__TweenEasyScale = TweenFire(id, ease, argument_count == 8 ? argument[7] : 0, global.TGMS.EasyUseDelta, delay, duration, str_xscale, x1, x2, str_yscale, y1, y2);
	return __TweenEasyScale;
}

function TweenEasyRotate(angle1, angle2, delay, duration, ease) 
{	/// @desc Tween instance's image angle
	/// @func TweenEasyRotate(angle1, angle2, delay, duration, ease, mode*)
	
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyRotate = "__TweenEasyRotate";
	static str_angle = "image_angle";
	
	if (variable_instance_exists(id, str_TweenEasyRotate) && TweenExists(__TweenEasyRotate))
	{
		TweenDestroy(__TweenEasyRotate);
	}

	__TweenEasyRotate = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, str_angle, angle1, angle2);
	return __TweenEasyRotate;
}

function TweenEasyFade(alpha1, alpha2, delay, duration, ease) 
{	/// @desc Tween instance's image alpha
	/// @func TweenEasyFade(alpha1, alpha2, delay, duration, ease, mode*)
	
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyFade = "__TweenEasyFade";
	static str_alpha = "image_alpha";
	
	if (variable_instance_exists(id, str_TweenEasyFade) && TweenExists(__TweenEasyFade))
	{
		TweenDestroy(__TweenEasyFade);
	}

	__TweenEasyFade = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, str_alpha, alpha1, alpha2);
	return __TweenEasyFade;
}

function TweenEasyBlend(col1, col2, delay, duration, ease) 
{	/// @desc Tween instance's image blend colour
	/// @func TweenEasyBlend(col1, col2, delay, duration, ease, mode*)
	
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyBlend = "__TweenEasyBlend";
	static str_blend = "image_blend";
	
	if (variable_instance_exists(id, str_TweenEasyBlend) && TweenExists(__TweenEasyBlend))
	{
		TweenDestroy(__TweenEasyBlend);
	}

	__TweenEasyBlend = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, str_blend, col1, col2);
	return __TweenEasyBlend;
}

function TweenEasyImage(index1, index2, delay, duration, ease) 
{	/// @desc Tween instance's image index
	/// @func TweenEasyImage(index1, index2, delay, duration, ease, mode*)
	

	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyImage = "__TweenEasyImage";
	static str_index = "image_index";
	
	if (variable_instance_exists(id, str_TweenEasyImage) && TweenExists(__TweenEasyImage))
	{
		TweenDestroy(__TweenEasyImage);
	}

	__TweenEasyImage = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, str_index, index1, index2);
	return __TweenEasyImage;
}
		
function TweenEasyTurn(dir1, dir2, delay, duration, ease) 
{	/// @desc Tween instance's direction
	/// @func TweenEasyTurn(dir1, dir2, delay, duration, ease, mode*)

	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyTurn = "__TweenEasyTurn";
	static str_direction = "direction";
	
	if (variable_instance_exists(id, str_TweenEasyTurn) && TweenExists(__TweenEasyTurn))
	{
		TweenDestroy(__TweenEasyTurn);
	}

	__TweenEasyTurn = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, str_direction, dir1, dir2);
	return __TweenEasyTurn;
}
	
function TweenEasyPath(path, absolute, delay, duration, ease) 
{	/// @desc Eases instance position using path
	/// @func TweenEasyPath(path, absolute, delay, duration, ease, mode*)

	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasyPath = "__TweenEasyPath";
	
	if (variable_instance_exists(id, str_TweenEasyPath) && TweenExists(__TweenEasyPath))
	{
		TweenDestroy(__TweenEasyPath);
	}
							
	__TweenEasyPath = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, absolute ? [TPPath, path] : [TPPath, path, x, y], 0, 1);
	return __TweenEasyPath;
}

function TweenEasySpeed(spd1, spd2, delay, duration, ease) 
{	/// @desc Tween instance's speed
	/// @func TweenEasySpeed(spd1, spd2, delay, duration, ease, mode*)

	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasySpeed = "__TweenEasySpeed";
	static str_speed = "speed";
	
	if (variable_instance_exists(id, str_TweenEasySpeed) && TweenExists(__TweenEasySpeed))
	{
		TweenDestroy(__TweenEasySpeed);
	}

	__TweenEasySpeed = TweenFire(id, ease, argument_count == 6 ? argument[5] : 0, global.TGMS.EasyUseDelta, delay, duration, str_speed, spd1, spd2);
	return __TweenEasySpeed;
}

function TweenEasySpeedHV(hspd1, vspd1, hspd2, vspd2, delay, duration, ease) 
{	/// @desc Tween instance's hspeed/vspeed
	/// @func TweenEasySpeedHV(hspd1, vspd1, hspd2, vspd2, delay, duration, ease, mode*)

	if (!instance_exists(o_SharedTweener)) SharedTweener();
	static str_TweenEasySpeedHV = "__TweenEasySpeedHV";
	static str_hspeed = "hspeed";
	static str_vspeed = "vspeed";
	
	if (variable_instance_exists(id, str_TweenEasySpeedHV) && TweenExists(__TweenEasySpeedHV))
	{
		TweenDestroy(__TweenEasySpeedHV);
	}

	__TweenEasySpeedHV = TweenFire(id, ease, argument_count == 8 ? argument[7] : 0, global.TGMS.EasyUseDelta, delay, duration, str_hspeed, hspd1, hspd2, str_vspeed, vspd1, vspd2);
	return __TweenEasySpeedHV;
}





