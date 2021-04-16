if (phase == 0) {
	if (showBubble) {
		if (!instance_exists(obj_encnotif))
			instance_create_depth(obj_player.x, obj_player.y - 20, 0, obj_encnotif);
	}
	drawSoulX = obj_player.x;
	drawSoulY = obj_player.y;
	global.cutscene = true;
	
	phase = 1;
}
if (phase == 1) && (!instance_exists(obj_encnotif)) {
	mus_pause(0);
	if (animateSoul) {
		if (blinkingPhase == 3) {
			var duration = (progressQuick ? room_speed / 2 : room_speed / 1.5);
			audio_play_sound(snd_enc2, 10, false);
			drawSoulTween = TweenFire(self, EaseLinear, TWEEN_MODE_ONCE, false, 0, duration, "drawSoulX", drawSoulX, soulTargetX, "drawSoulY", drawSoulY, soulTargetY);
			phase = 2;
		}
		else if (blinkingPhase < 3) {
			if (alarm[0] < 0)
				alarm[0] = (progressQuick ? 2 : 4);
		}
	}
	else {
		room_goto(room_battle);
		global.cutscene = false;
	}
}
if (phase == 2) {
	if (!TweenIsPlaying(drawSoulTween)) {
		if (alarm[1] < 0)
			alarm[1] = (progressQuick ? room_speed / 8 : room_speed / 4);
	}	
}