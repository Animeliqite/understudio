if (fade) {
	fadeTween = TweenFire(obj_gamecamera, EaseLinear, TWEEN_MODE_ONCE, false, 0, fadeDuration, screenAlpha, 0, 1);
	obj_gamecamera.screenColor = fadeColor;
}