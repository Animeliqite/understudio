function game_fade( color, start, destination, duration ){
	if (!instance_exists(obj_fader)) {
		var fader = instance_create_depth(0, 0, -9999, obj_fader);
		TweenDestroy(fader.tween);
		
		fader.color = color;
		fader.tween = TweenFire(fader, EaseLinear, TWEEN_MODE_ONCE, false, 0, duration, "alpha", start, destination);
	}
	else
		instance_destroy(obj_fader);
}