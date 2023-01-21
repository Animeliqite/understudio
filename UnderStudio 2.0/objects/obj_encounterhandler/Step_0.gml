/// @description Functionality

switch (state) {
	case 0:
		switch (subState) {
			case 0:
				if (!encounterExclamation) state = 1;
				else {
					if (instance_exists(encounterObject)) {
						sfx_play(snd_exclamation);
						instance_create_depth(encounterObject.x, encounterObject.y - sprite_yoffset - 15, -9999, obj_exclamation);
						subState = 1;
					} else state = 1;
				}
				break;
			case 1:
				encounterTimer++;
				if (encounterTimer > game_get_speed(gamespeed_fps) / 2) {
					encounterTimer = 0;
					subState = 0;
					state = 1;
				}
				break;
		}
		break;
	case 1:
		if (encounterAnimation) {
			encounterObject.visible = false;
			encounterBlinkPhase++;
			if (encounterBlinkPhase % 2 == 0) encounterHeartShow = false;
			if (encounterBlinkPhase % 4 == 0) encounterHeartShow = true;
		
			if (encounterBlinkPhase % 4 == 0)
				sfx_play(snd_noise);
			if (encounterBlinkPhase == 12) {
				encounterBlinkPhase = 0;
				state = 2;
			}
		}
		else {
			state = 2;
			subState = 1;
		}
		break;
	case 2:
		switch (subState) {
			case 0:
				sfx_play(snd_heartmove);
				execute_tween(id, "heartX", heartGoToX, "linear", 0.5, false);
				execute_tween(id, "heartY", heartGoToY, "linear", 0.5, false);
				subState = 1;
				break;
			case 1:
				encounterMovePhase++;
				if (encounterMovePhase == game_get_speed(gamespeed_fps) / 2) {
					screen_fade(1,0,0.25);
					room_goto(rm_battle);
				}
				break;
		}
		break;
}