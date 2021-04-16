if (cooldown > 0)
	cooldown--;

if (fade) {
	if (fadePhase == 0) {
		fadeTween = game_fade(fadeColor, -1, 1, fadeDuration);
		global.cutscene = true;
		persistent = true;
		fadePhase = 1;
	}
	if (fadePhase == 1) && (!TweenIsPlaying(fadeTween)) {
		global.spawn = -1;
		room_goto(targetRoom);
		
		global.cutscene = false;
		cooldown = 2;
		fadePhase = 2;
	}
	if (fadePhase == 2) && (cooldown <= 0) {
		fadeTween = game_fade(fadeColor, -1, 0, fadeDuration);
		var door = id;
		persistent = false;
		
		if (targetEntrance != -1) && (instance_exists(obj_player)) && (instance_exists(obj_entrance)) {
			for (var i = 0; i < instance_number(obj_entrance); ++i) {
				with (obj_entrance) {
					if (door.targetEntrance == entranceNo) {	
						global.playerX = x;
						global.playerY = y;
						
						with (obj_player)
							event_user(0);
						
						break;
					}
				}
			}
		}
		if (targetRoom != room)
			instance_destroy();
		else {
			visible = false;
			fade = false;
			fadePhase = 0;
		}
	}
}