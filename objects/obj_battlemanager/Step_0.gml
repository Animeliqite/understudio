/// @description Battle Functionality
if (cooldown > 0)
	cooldown--;

if (menuno == -4) && (cooldown <= 0) { // TURN START
	if (instance_exists(obj_battleheart)) && (!obj_battleheart.moveable) && (!transformReady) {
		obj_battleheart.moveable = true;
		with (monsters[monsterIndex])
			event_user(4);
	}
	if (turnTime > 0) && (!transformReady)
		turnTime--;
	else if (turnTime == 0 && (!transformReady)) {
		board_reset();
		instance_destroy(obj_battleheart);
		transformReady = true;
		with (monsters[monsterIndex])
			event_user(5);
	}
	if (turnTime == 0) && (transformReady) && (!board_is_moving()) {
		menuno = 0;
		transformReady = false;
	}
}
if (menuno == -3) && (cooldown <= 0) { // TURN PREPARATION
	if (!instance_exists(obj_battleheart)) {
		instance_create(-9999, -9999, obj_battleheart);
		bt_centerheart();
	}
}
if (menuno == -2) && (cooldown <= 0) { // WIN DIALOGUE
	var xpRewardTotal = 0;
	var goldRewardTotal = 0;
	mus_stop(0);
	
	for (var i = 0; i < array_length(monsters); i++) {
		xpRewardTotal += string(monsterRewards[i][0]);
		goldRewardTotal += string(monsterRewards[i][1]);
	}
	
	if (!instance_exists(obj_writer)) {
		create_writer(global.boardX1 + 20, global.boardY1 + 20, [get_message("battleWinningMessage")], [string(xpRewardTotal), string(goldRewardTotal)], fnt_dialogue, c_white, 0, [snd_text_battle], 1, true, false, false);
		global.xp += xpRewardTotal;
		global.gold += goldRewardTotal;
	}
	if (obj_writer.isDone) && (global.confirm) {
		game_fade(c_black, -1, 1, room_speed / 3);
		mus_set_volume(0, 0, room_speed / 3);
		if (alarm[0] < 0)
			alarm[0] = room_speed / 3;
	}
}
else if (menuno == -1) && (cooldown <= 0) { // DIALOGUE
	if (obj_writer.isDone) && (global.confirm) {
		menuno = 0;
		instance_destroy(obj_writer);
	}
}
else if (menuno == 0) && (cooldown <= 0) { // BUTTON
	actWriters = [-1, -1, -1, -1, -1, -1];
	if (global.left_press) {
		if (buttonIndex > 0)
			buttonIndex--;
		else
			buttonIndex = buttonCount;
		audio_play_sound(snd_menuswitch, 0, false);
	}
	
	if (global.right_press) {
		if (buttonIndex < buttonCount)
			buttonIndex++;
		else
			buttonIndex = 0;
		audio_play_sound(snd_menuswitch, 0, false);
	}
	
	if (global.confirm) {
		switch (buttonIndex) {
			case 2:
				menuno = 3;
				break;
			case 3:
				menuno = 4;
				break;
			default:
				menuno = 1;
		}
		cooldown = 2;
		instance_destroy(obj_writer);
		audio_play_sound(snd_menuselect, 0, false);
	}
}
else if (menuno == 1) && (cooldown <= 0) { // MONSTER SELECT
	if (global.up_press) {
		if (monsterIndex > 0)
			monsterIndex--;
		else
			monsterIndex = array_length(monsters) - 1;
			
		if (array_length(monsters) > 1)
			audio_play_sound(snd_menuswitch, 0, false);
	}
	
	if (global.confirm) {
		switch (buttonIndex) {
			case 0:
				instance_create_depth(0, 0, -1000, obj_attackmanager);
				menuno = 999;
				break;
			case 1:
				menuno = 2;
				break;
			default:
				menuno = 0;
		}
		cooldown = 2;
		instance_destroy(obj_writer);
		audio_play_sound(snd_menuselect, 0, false);
	}
	
	if (global.down_press) {
		if (monsterIndex < array_length(monsters) - 1)
			monsterIndex++;
		else
			monsterIndex = 0;
			
		if (array_length(monsters) > 1)
			audio_play_sound(snd_menuswitch, 0, false);
	}
	
	if (global.cancel) {
		monsterIndex = 0;
		menuno = 0;
		cooldown = 2;
		instance_destroy(obj_writer);
	}
}
else if (menuno == 2) && (cooldown <= 0) { // ACT
	var actMax = array_length(battleMessages[1][bt_getcurrent_monster()]);
	if (global.left_press) {
		if (actIndex > 0)
			actIndex--;
	}
	if (global.right_press) {
		if (actIndex < actMax - 1)
			actIndex++;
	}
	if (global.up_press) {
		if (actIndex > 1)
			actIndex -= 2;
	}
	if (global.down_press) {
		if (actIndex < actMax - 2)
			actIndex += 2;
	}
	if (global.confirm) {
		menuno = -1;
		actIndex = 0;
		cooldown = 2;
		instance_destroy(obj_writer);
		if (!instance_exists(obj_writer))
			create_writer(global.boardX1 + 20, global.boardY1 + 20, [battleMessages[2][monsterIndex][actIndex]], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
	}
	if (global.cancel) {
		menuno = 0;
		actIndex = 0;
		cooldown = 2;
		instance_destroy(obj_writer);
	}
}
else if (menuno == 4) && (cooldown <= 0) && (!fleeing) { // MERCY
	if (global.up_press) {
		if (mercyIndex > 0)
			mercyIndex--;
		else
			mercyIndex = (battleFleeable ? 1 : 0);
			
		if (battleFleeable)
			audio_play_sound(snd_menuswitch, 0, false);
	}
	
	if (global.down_press) {
		if (mercyIndex < (battleFleeable ? 1 : 0))
			mercyIndex++;
		else
			mercyIndex = 0;
			
		if (battleFleeable)
			audio_play_sound(snd_menuswitch, 0, false);
	}
	
	if (global.cancel) {
		mercyIndex = 0;
		menuno = 0;
		cooldown = 2;
		instance_destroy(obj_writer);
	}
	
	if (global.confirm) {
		instance_destroy(obj_writer);
		switch (mercyIndex) {
			case 0:
				for (var i = 0; i < array_length(monsters); i++) {
					if (monsterSpareable[i]) && (!monsterSpared[i]) {
						monsterSpared[i] = true;
						with (monsters[i])
							event_user(1);
						
						if (monsterSpared[i] == true) {
							menuno = -2;
							cooldown = 2;
						}
					}
				}
				break;
			case 1:
				randomize();
				var chances = random(100);
				
				if (chances < 33) {
					fleeing = true;
					audio_play_sound(snd_flee, 0, false);
				
					if (!instance_exists(obj_battleheart_gtfo))
						instance_create_depth(global.boardX1 + 40, global.boardY1 + 35 + (mercyIndex * 35), depth_battle.heart, obj_battleheart_gtfo);
				
					if (!instance_exists(obj_writer))
						create_writer(global.boardX1 + 20, global.boardY1 + 20, ["   " + choose(get_message("battleFleeingMessage_0"), get_message("battleFleeingMessage_1"), get_message("battleFleeingMessage_2"))], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
				}
				break;
		}
		cooldown = 2;
		audio_play_sound(snd_menuselect, 0, false);
	}
}

if (fleeing == true) {
	if (obj_writer.isDone) && (global.confirm) {
		game_fade(c_black, -1, 1, room_speed / 3);
		mus_set_volume(0, 0, room_speed / 3);
		if (alarm[0] < 0)
			alarm[0] = room_speed / 3;
	}
}