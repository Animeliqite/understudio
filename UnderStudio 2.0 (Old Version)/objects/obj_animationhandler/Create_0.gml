/// @description Initialize

curveTimer = 0; // Current amount of how much the animation curve has progressed
curveName = "linear"; // The curve the animation is going to progress with
targetInstance = undefined; // The instance to create the tween on
targetVariable = undefined; // The target variable to create the tween on
oldValue = undefined; // The target variable value from the beginning of the tween
newValue = undefined; // The value the target variable is going to be
duration = undefined; // The duration the animation is going to have
delay = 0; // The duration the animation is going to wait before tweening