function game_fade( color, start, destination, duration ) {
	var fader = obj_fader;
	
	if (start == -1)
		start = fader.alpha;
	
	fader.color = color;
	fader.tween = TweenFire(fader, EaseLinear, TWEEN_MODE_ONCE, false, 0, duration, "alpha", start, destination);
	
	return fader.tween;
}