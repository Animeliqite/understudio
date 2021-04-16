if (cooldown > 0)
	cooldown--;

if (menuno == 0) && (cooldown == 0) {
	if (!hasName)
		global.name = "";
	
	if (global.up_press) {
		if (sel[0] > 0)
			sel[0]--;
		else
			sel[0] = 1;
	}
	if (global.down_press) {
		if (sel[0] < 1)
			sel[0]++;
		else
			sel[0] = 0;
	}
	if (global.confirm) {
		switch (sel[0]) {
			case 0:
				menuno = 1;
				cooldown = 2;
				break;
			case 1:
				cooldown = 2;
				//TODO: Settings
				break;
		}
	}
}
if (menuno == 1) && (cooldown == 0) {
	hasName = true;
	
	if (global.left_press) {
		if (sel[1] > 0) && (sel[1] < 53)
			sel[1]--;
		else if (sel[1] > 53)
			sel[1]--;
		else
			sel[1] = 55;
	}
	if (global.right_press) {
		if (sel[1] != 51) && (sel[1] < 55)
			sel[1]++;
		else
			sel[1] = 53;
	}
	if (global.up_press) {
		if (sel[1] > 25) && (sel[1] < 31)
			sel[1] -= 5;
		else if (sel[1] > 30) && (sel[1] < 33)
			sel[1] -= 12;
		else if (sel[1] == 53) // Quit
			sel[1] = 47;
		else if (sel[1] == 54) // Backspace
			sel[1] = 49;
		else if (sel[1] == 55) // Done
			sel[1] = 45;
		else if (sel[1] >= 0) && (sel[1] < 2) // Quit
			sel[1] = 53;
		else if (sel[1] > 1) && (sel[1] < 5) // Backspace
			sel[1] = 54;
		else if (sel[1] > 4) && (sel[1] < 7) // Done
			sel[1] = 55;
		else if (sel[1] > 6)
			sel[1] -= 7;
	}
	if (global.down_press) {
		if (sel[1] > 20) && (sel[1] < 26)
			sel[1] += 5;
		else if (sel[1] > 18) && (sel[1] < 21)
			sel[1] += 12;
		else if (sel[1] > 46) && (sel[1] < 49) // Quit
			sel[1] = 53;
		else if (sel[1] > 48) && (sel[1] < 52) // Backspace
			sel[1] = 54;
		else if (sel[1] > 44) && (sel[1] < 47) // Done
			sel[1] = 55;
		else if (sel[1] == 53) // Quit
			sel[1] = 0;
		else if (sel[1] == 54) // Backspace
			sel[1] = 2;
		else if (sel[1] == 55) // Done
			sel[1] = 5;
		else if (sel[1] < 45)
			sel[1] += 7;
	}
	if (global.confirm) {
		if (sel[1] < 53) {
			if (string_length(global.name) >= 6)
				global.name = string_delete(global.name, string_length(global.name), 1);
		
			if (sel[1] > 25)
				global.name += chr(71 + sel[1]);
			else
				global.name += chr(65 + sel[1]);
		}
		else if (sel[1] == 53) {
			menuno = 0;
			cooldown = 2;
		}
		else if (sel[1] == 54) {
			if (string_length(global.name) > 0)
				global.name = string_delete(global.name, string_length(global.name), 1);
		}
		else if (sel[1] == 55) {
			menuno = 2;
			cooldown = 2;
			
			nameX = 0;
			nameY = 0;
			nameScale = 1;
			
			nameTween = TweenFire(self, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed * 4, "nameX", nameX, -60, "nameY", nameY, 80, "nameScale", nameScale, 3);
			
			event_user(0);
		}
	}
	if (global.cancel) {
		if (string_length(global.name) > 0)
			global.name = string_delete(global.name, string_length(global.name), 1);
	}
}
if (menuno == 2) && (cooldown == 0) {
	if (global.right_press) && (nameChooseable) && (!fadingToWhite) {
		if (sel[2] < 1)
			sel[2]++;
		else
			sel[2] = 0;
	}
	if (global.left_press) && (nameChooseable) && (!fadingToWhite) {
		if (sel[2] > 0)
			sel[2]--;
		else
			sel[2] = 1;
	}
	if (global.confirm) && (!fadingToWhite) {
		switch (sel[2]) {
			case 0:
				menuno = (tempName != "" ? 3 : 1);
				cooldown = 2;
				
				nameChooseable = true;
				nameResponse = "";
				break;
			case 1:
				game_fade(c_white, -1, 1, room_speed * 5.5);
				if (alarm[0] < 0)
					alarm[0] = room_speed * 5.5;
				
				fadingToWhite = true;
				menuno = 999;
				
				mus_stop(0);
				mus_play(0, "cymbal", 1, 0.95);
				break;
		}
	}
}
if (menuno == 3) && (cooldown == 0) {
	if (global.up_press) && (sel[3] == 2) {
		sel[3] = 0;
	}
	if (global.down_press) && (sel[3] < 2) {
		sel[3] = 2;
	}
	if (global.left_press) {
		if (sel[3] > 0)
			sel[3]--;
		else
			sel[3] = 1;
	}
	if (global.right_press) {
		if (sel[3] < 1)
			sel[3]++;
		else
			sel[3] = 0;
	}
	
	if (global.confirm) {
		switch (sel[3]) {
			case 0:
				scr_load();
				room_goto(currentroom);
				mus_stop(0);
				break;
			case 1:
				tempName = global.name;
				nameResponse = get_message("nameResultAlreadyChosen");
				
				nameX = 0;
				nameY = 0;
				nameScale = 1;
				
				nameTween = TweenFire(self, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed * 4, "nameX", nameX, -60, "nameY", nameY, 80, "nameScale", nameScale, 3);
				
				menuno = 2;
				cooldown = 2;
				break;
			case 2:
				//TODO: Settings
				break;
		}
	}
}