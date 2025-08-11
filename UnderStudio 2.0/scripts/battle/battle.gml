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

// Executes enemy event from battle
function battle_execute_enemy_event(enemy_no, event) {
	var enemy = battleEnemies[enemy_no];
	
	if (instance_exists(enemy)) {
		enemy.executeEnemyEvent(event);
	}
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
	return (global.playerAT + global.playerATWeapon + floor(median(10, global.playerHP._max, 90) - 10) / 10) * floor(dmg);
}