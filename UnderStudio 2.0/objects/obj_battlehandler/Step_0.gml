/// @description Battle System Logic

// --- Per-Frame Logic ---

// Text skipping functionality for the writer
var _flavorWriter = instance_find(flavorWriter, 0);
if (instance_exists(_flavorWriter)) {
	if (BT_SHIFT_P && !_flavorWriter.completed) {
		_flavorWriter.skipText = true;
	}
}

// If no enemies exist, end the battle
if (!battle_enemy_exists() && !battle_ended) {
	battle_set_state(BATTLE_STATE.RESULT);
	battle_ended = true;
}

// --- Main State Machine ---

switch (state) {
	// =================================================================
	case BATTLE_STATE.BUTTON:
		var _prevSelection = selection_button;
		battle_get_soul().visible = true;
		highlight_buttons = true;
	
		// Run once on state entry
		if (!state_executed_once) {
			battle_set_menu_text(flavorText);
			state_executed_once = true;
		}
	
		// Handle Input
		if (BT_RIGHT_P) selection_button = number_add_wrap(selection_button, 0, 4);
		if (BT_LEFT_P) selection_button = number_sub_wrap(selection_button, 0, 4);
		
		// Sound effect
		if (_prevSelection != selection_button) {
			sfx_play(snd_menumove);
		}
	
		// Handle Action
		if (BT_ENTER_P) {
			sfx_play(snd_menuselect);
			instance_destroy(_flavorWriter);
			
			// Transition to the next state based on the selected button
			battle_set_state(BATTLE_STATE.PLAYER_ACTION);
			
			switch (selection_button) {
				case BATTLE_BUTTON.FIGHT:
					battle_set_menu(BATTLE_MENU.ENEMY_SELECTION);
					battle_set_next_menu(BATTLE_MENU.PLAYER_FIGHT);
					break;
				case BATTLE_BUTTON.ACT:
					battle_set_menu(BATTLE_MENU.ENEMY_SELECTION);
					battle_set_next_menu(BATTLE_MENU.PLAYER_ACT);
					break;
				case BATTLE_BUTTON.ITEM:
					battle_set_menu(BATTLE_MENU.PLAYER_ITEM);
					break;
				case BATTLE_BUTTON.MERCY:
					battle_set_menu(BATTLE_MENU.PLAYER_MERCY);
					break;
			}
		}
		break;

	// =================================================================
	case BATTLE_STATE.PLAYER_ACTION:
		switch (menu) {
			// --- Enemy Selection Sub-menu ---
			case BATTLE_MENU.ENEMY_SELECTION:
				var _selectionSize = array_length(battleEnemies) - 1;
				var _prevSelection = selection_enemy;
				
				battle_get_soul().visible = true;
				
				// Position the heart icon
				var _board = obj_battleboardhandler;
				var _heartX = _board._x - _board.width + 40;
				var _heartY = _board._y - _board.height + 36 + (selection_enemy * 38);
				with (obj_battleheart) {
					x = _heartX;
					y = _heartY;
				}
				
				// Build and draw the enemy list string
				var _str = "";
				for (var i = 0; i <= _selectionSize; i++) {
					_str += $"    * {battleEnemies[i].enemyName}\n";
				}
				drawMenuText(_str);
				
				// Input
				if (BT_UP_P) selection_enemy = max(0, selection_enemy - 1);
				if (BT_DOWN_P) selection_enemy = min(_selectionSize, selection_enemy + 1);
				
				if (_prevSelection != selection_enemy) {
					sfx_play(snd_menumove);
				}
				
				// Actions
				if (BT_ENTER_P) {
					battle_set_menu(battle_get_next_menu());
					battle_set_next_menu(BATTLE_MENU.ENEMY_DAMAGE); // This is the common next step
					sfx_play(snd_menuselect);
					highlight_buttons = false;
					flavorActionText = "";
				}
				
				if (BT_SHIFT_P) {
					battle_set_state(BATTLE_STATE.BUTTON);
					battle_set_menu(BATTLE_MENU.NONE);
					flavorActionText = "";
				}
				break;
			
			// --- Other sub-menus are single-action, ideal for a helper function ---
			case BATTLE_MENU.PLAYER_FIGHT:
				battle_execute_once_in_menu(function() {
					battle_get_soul().visible = false;
					battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.PLAYER_FIGHT);
				});
				break;
				
			case BATTLE_MENU.ENEMY_DAMAGE:
				battle_execute_once_in_menu(function() {
					battle_get_soul().visible = false;
					battle_set_next_menu(BATTLE_MENU.ENEMY_DEATH);
					battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.ENEMY_DAMAGE);
				});
				break;
				
			case BATTLE_MENU.ENEMY_DEATH:
				battle_execute_once_in_menu(function() {
					battle_get_soul().visible = false;
					battle_set_state(BATTLE_STATE.TURN_PREPARATION); // Go to next state directly
					battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.ENEMY_DAMAGE_AFTERMATH);
				});
				break;
		}
		break;

	// =================================================================
	case BATTLE_STATE.TURN_PREPARATION:
		battle_execute_once_in_state(function() {
			battle_get_soul().visible = true;
			battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.TURN_PREPARATION);
		});
		break;

	// =================================================================
	case BATTLE_STATE.RESULT:
		if (!state_executed_once) {
			battle_set_menu_text(string_ext(resultText, [reward_xp, reward_gold]));
			song_stop(battleSong);
		
			global.playerEXP += reward_xp;
			global.playerGold += reward_gold;
		
			state_executed_once = true;
		}
		else if (instance_exists(_flavorWriter) && BT_ENTER_P && _flavorWriter.completed) {
			// Start fade out, then change room, then fade back in
			screen_fade(0, 1, 10);
			timer_set(function() { room_goto(global.prevRoom); }, 10, []);
			timer_set(function() { screen_fade(1, 0, 10); }, 11, []);
			
			// Set a neutral state to stop battle processing
			battle_set_state(BATTLE_STATE.NONE);
		}
		break;
}