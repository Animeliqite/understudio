/// @description Functionality

// Create the animation
curveTimer += (!is_undefined(duration) ? 1 / (duration * room_speed) : 0.01);
if (curveTimer < 1) {
	variable_instance_set(	targetInstance, targetVariable,
							oldValue + 
							animcurve_channel_evaluate(
							animcurve_get_channel(anc_easings, curveName),
							curveTimer) * newValue);
}
else instance_destroy();
curveTimer = clamp(curveTimer, 0, 1);