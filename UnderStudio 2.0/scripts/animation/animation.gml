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

function tween_exists(instance, variable = undefined) {
	for (var i = 0; i < instance_number(obj_animationhandler); i++) {
		with (instance_find(obj_animationhandler,i)) {
			if (targetInstance == instance) {
				if (variable != undefined) {
					if (targetVariable == variable)
						return true;
					else
						return false;
				}
				else {
					return true;
				}
			}
			else {
				return false;
			}
		}
	}
}

function tween_destroy(instance, variable = undefined, skip = false) {
	var inst = instance_find_equal_value(obj_animationhandler, "targetInstance", instance);
	
	if (instance_exists(inst)) {
		if (variable != undefined) {
			if (inst.targetVariable == variable) {
				if (skip) inst.targetVariable = inst.newValue;
				instance_destroy(inst);
			}
		}
		else {
			instance_destroy(inst);
		}
	}
}

// This script creates a fader object which fades in/out the screen.
function screen_fade(alphaBegin, alphaStop, duration = 15, fadingColor = c_black) {
	// If the fading handler exists, destroy it
	if (instance_exists(obj_fadinghandler))
		instance_destroy(obj_fadinghandler);
	
	// Set the values
	var faderInst = instance_create_depth(0, 0, -1000, obj_fadinghandler)
	with (faderInst) {
		faderAlpha = alphaBegin;
		faderAlphaTarget = alphaStop;
		faderDuration = duration;
		faderColor = fadingColor;
	}
	
	return faderInst;
}