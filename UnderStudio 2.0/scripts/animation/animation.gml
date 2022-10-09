// This script creates an animation on an instance relatively to the variable's value
function execute_tween(instance, variable, targetValue, curveSubName = "linear", seconds = 1, relative = false, delay = 0) {
	// Set the values
	with (instance_create_depth(0, 0, 0, obj_animationhandler)) {
		curveTimer = 0;
		curveName = curveSubName;
		targetInstance = instance;
		targetVariable = variable;
		oldValue = variable_instance_get(instance, variable);
		newValue = targetValue - (relative ? 0 : variable_instance_get(instance, variable));
		duration = seconds;
		self.delay = delay;
	}
}

// This script creates a fader object which fades in/out the screen.
function screen_fade(alphaBegin, alphaStop, duration = 0.25, fadingColor = c_black) {
	// Set the values
	var faderInst = instance_create_depth(0, 0, -9999, obj_fadinghandler)
	with (faderInst) {
		faderAlpha = alphaBegin;
		faderAlphaTarget = alphaStop;
		faderDuration = duration;
		faderColor = fadingColor;
	}
	
	return faderInst;
}