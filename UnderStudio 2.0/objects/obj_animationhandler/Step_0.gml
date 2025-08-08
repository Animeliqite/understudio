/// @description Functionality

// Create the animation
if (delay > 0)
	delay -= 1;
else {
	if (instance_exists(targetInstance)) {
		curveTimer += (!is_undefined(duration) ? 1 / duration : 0.01);
		if (curveTimer < 1) {
			variable_instance_set(	targetInstance, targetVariable,
									oldValue + 
									animcurve_channel_evaluate(
									animcurve_get_channel(anc_easings, curveName),
									curveTimer) * newValue);
		}
		else {
            variable_instance_set(targetInstance, targetVariable, oldValue + newValue);
            instance_destroy();
        }
		curveTimer = clamp(curveTimer, 0, 1);
	}
	else {
		instance_destroy();
	}
}