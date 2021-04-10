if (!TweenIsActive(tween)) && (tweening) {
	tweening = false;
	instance_destroy();
}
alarm[0] = 1;