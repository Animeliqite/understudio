/// @description Functionality

switch (state) {
	case 0:
		if (instance_exists(writer)) {
			if (bt_enter_p)
				state = 2;
			
			if (writer.completed) {
				instance_destroy(writer);
				if (textNo < array_length(text) - 1) {
					fading = true;
					textNo++;
					state = 1;
				}
				else state = 2;
			}
		}
		
		break;
	case 1:
		switch (subState) {
			case 0:
				execute_tween(id, "image_alpha", 0, "linear", 0.5, false);
				subState++;
			case 1:
				if (timer < 0.4)
					timer += 0.5 / game_get_speed(gamespeed_fps);
				else {
					execute_tween(id, "image_alpha", 1, "linear", 0.5, false);
					runText(text[textNo]);
					image_index++;
					fading = false;
					subState = 0;
					timer = 0;
					state = 0;
				}
				break;
		}
		break;
	case 2:
		switch (subState) {
			case 0:
				execute_tween(id, "image_alpha", 0, "linear", 1, false);
				song_set_volume(music, 0, 1);
				instance_destroy(writer);
				subState++;
			case 1:
				if (timer < 0.9)
					timer += 1 / game_get_speed(gamespeed_fps);
				else {
					song_stop(music);
					room_goto_next();
				}
				break;
		}
		break;
}