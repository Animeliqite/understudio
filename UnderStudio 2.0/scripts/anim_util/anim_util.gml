// This script creates an animation on an instance relatively to the variable's value
function execute_tween(instance, variable, targetValue, curveSubName, seconds, relative) {
	// Set the values
	with (instance_create_depth(0, 0, 0, obj_animationhandler)) {
		curveTimer = 0;
		animationData = {
			curveName : curveSubName,
			targetInstance : instance,
			targetVariable : variable,
			oldValue : variable_instance_get(instance, variable),
			newValue : targetValue - (relative ? 0 : variable_instance_get(instance, variable)),
			duration : seconds
		};
	}
}