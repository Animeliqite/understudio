/// @description Functionality

// Create the animation
var data = animationData;
curveTimer += (!is_undefined(data.duration) ? 1 / (data.duration * room_speed) : 0.01);
if (curveTimer < 1) {
	variable_instance_set(	data.targetInstance, data.targetVariable,
							data.oldValue + 
							animcurve_channel_evaluate(
							animcurve_get_channel(anc_easings, data.curveName),
							curveTimer) * data.newValue);
}
else instance_destroy();
curveTimer = clamp(curveTimer, 0, 1);