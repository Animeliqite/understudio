// Retrieves the information of encounters
function battle_retrieve_enemies() {
	var _enemy = [];
	switch (global.encounterID) {
		case 0:
			_enemy = [
				instance_create_depth(320, 240, 0, obj_battle_enemy_test)
			];
			break;
	}
	return _enemy;
}

// Sets flavor text
function battle_set_menu_text(text) {
	with (obj_battlehandler) {
        flavorText = text;
        flavorFace = global.speakers.GetSpeakerData(flavorSpeaker, "Face");
        flavorVoice = global.speakers.GetSpeakerData(flavorSpeaker, "Voice");
        flavorFont = global.speakers.GetSpeakerData(flavorSpeaker, "Font");
		
        event_user(0);
    }
}

// Executes battle state once
function battle_execute_once_in_state(_function) {
	var bt = obj_battlehandler;
	
	if (!bt.state_executed_once) {
		_function();
		bt.state_executed_once = true;
	}
}

// Executes battle menu state once
function battle_execute_once_in_menu(_function) {
	var bt = obj_battlehandler;
	
	if (!bt.menu_executed_once) {
		_function();
		bt.menu_executed_once = true;
	}
}

// Executes enemy event from battle
function battle_execute_enemy_event(enemy_no, event) {
	var enemy = battleEnemies[enemy_no];
	
	if (instance_exists(enemy)) {
		enemy.executeEnemyEvent(event);
	}
}

// Creates a speech bubble
function battle_create_speechbubble(_x, _y, text, width, height) {
	speech_bubble = instance_create_depth(_x, _y, 0, obj_battlespeechbubblehandler);
	speech_bubble.writer_text = text;
	speech_bubble.width = width;
	speech_bubble.height = height;
	
	return speech_bubble;
}

function battle_accumulate_rewards(xp, gold) {
	with (obj_battlehandler) {
		reward_xp += xp;
		reward_gold += gold;
	}
}

// Removes an enemy from the list
function battle_remove_enemy(enemy_no) {
	with (obj_battlehandler) {
		battleEnemies = array_delete(battleEnemies, enemy_no, 1);
	}
}

// Checks if any enemies exist in the list
function battle_enemy_exists() {
	return array_length(obj_battlehandler.battleEnemies) != 0;
}

// Gets the selected battle enemy
function battle_get_selected_enemy() {
	return obj_battlehandler.selection_enemy;
}

// Sets the battle state
function battle_set_state(state) {
	with (obj_battlehandler) {
		self.state = state;
		state_executed_once = false;
	}
}

// Sets the next battle state
function battle_set_next_state(state) {
	with (obj_battlehandler) {
		state_next = state;
	}
}

// Gets the next battle state
function battle_get_next_state() {
	return obj_battlehandler.state_next;
}

// Sets the battle menu
function battle_set_menu(menu) {
	with (obj_battlehandler) {
		self.menu = menu;
		menu_executed_once = false;
	}
}

// Sets the next battle menu
function battle_set_next_menu(state) {
	with (obj_battlehandler) {
		menu_next = state;
	}
}

// Gets the next battle menu
function battle_get_next_menu() {
	return obj_battlehandler.menu_next;
}

// Gets the battle soul
function battle_get_soul() {
	return obj_battleheart;
}

// Calculates damage depending on player stats
function battle_calculate_dmg(dmg) {
	return floor((global.playerAT + global.playerATWeapon + floor(median(10, global.playerHP._max, 90) - 10) / 10) * dmg);
}