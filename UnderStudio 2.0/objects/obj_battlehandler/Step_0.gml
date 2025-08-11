/// @description Functionality

var _board = obj_battleboardhandler;

if (state == BATTLE_STATE.BUTTON) {
	// Initialize the variables
	var _buttonSize = instance_number(obj_battlebuttonhandler);
	var _prevSelection = selection_button;
	battle_get_soul().visible = true;
	highlight_buttons = true;
	
	if (!state_executed_once) {
		battle_set_menu_text(flavorText);
		state_executed_once = true;
	}
	
	// Check if those keys are pressed
	if (BT_RIGHT_P) selection_button = number_add_wrap(selection_button, 0, _buttonSize);
	if (BT_LEFT_P) selection_button = number_sub_wrap(selection_button, 0, _buttonSize);
	
	// Check if a button is pressed
	if (BT_ENTER_P) {
		if (selection_button == 0) {
			battle_set_state(BATTLE_STATE.PLAYER_ACTION);
			battle_set_menu(BATTLE_MENU.ENEMY_SELECTION);
			battle_set_next_menu(BATTLE_MENU.PLAYER_FIGHT);
		}
		else if (selection_button == 1) {
			battle_set_state(BATTLE_STATE.PLAYER_ACTION);
			battle_set_menu(BATTLE_MENU.ENEMY_SELECTION);
			battle_set_next_menu(BATTLE_MENU.PLAYER_ACT);
		}
		else if (selection_button == 2) {
			battle_set_state(BATTLE_STATE.PLAYER_ACTION);
			battle_set_menu(BATTLE_MENU.PLAYER_ITEM);
		}
		else if (selection_button == 3) {
			battle_set_state(BATTLE_STATE.PLAYER_ACTION);
			battle_set_menu(BATTLE_MENU.PLAYER_MERCY);
		}
			
		sfx_play(snd_menuselect);
		instance_destroy(flavorWriter);
	}
	
	if (BT_SHIFT_P) {
		if (instance_exists(flavorWriter)) {
			if (!flavorWriter.completed)
				flavorWriter.skipText = true;
		}
	}
		
	// Check if the previous selection is not the current selection
	if (_prevSelection != selection_button)
		sfx_play(snd_menumove);
	_prevSelection = selection_button;
}
else if (state == BATTLE_STATE.PLAYER_ACTION) {
	if (menu == BATTLE_MENU.ENEMY_SELECTION) {
		battle_get_soul().visible = true;
		// Initialize the variables
		var _selectionSize = array_length(battleEnemies) - 1;
		var _prevSelection = selection_enemy;
		var _handler = id;
		
		with (obj_battleheart) {
			x = _board._x - _board.width + 40;
			y = _board._y - _board.height + 36 + (_handler.selection_enemy * 38);
		}
		
		var _str = "";
		for (var i = 0; i < _selectionSize + 1; i++) {
			_str += $"    * {battleEnemies[i].enemyName} #"
		}
		
		drawMenuText(_str);
		
		// Check if those keys are pressed
		if (BT_UP_P) selection_enemy = number_sub(selection_enemy, 0);
		if (BT_DOWN_P) selection_enemy = number_add(selection_enemy, _selectionSize);
		
		// Check if a button is pressed
		if (BT_ENTER_P) {
			battle_set_menu(battle_get_next_menu());
			battle_set_next_menu(BATTLE_MENU.ENEMY_DAMAGE);
			
			sfx_play(snd_menuselect);
			
			highlight_buttons = false;
			flavorActionText = "";
		}
		
		if (BT_SHIFT_P) {
			battle_set_state(BATTLE_STATE.BUTTON);
			battle_set_menu(BATTLE_MENU.NONE);
			
			flavorActionText = "";
		}
		
		// Check if the previous selection is not the current selection
		if (_prevSelection != selection_enemy)
			sfx_play(snd_menumove);
		_prevSelection = selection_enemy;
	}
	else if (menu == BATTLE_MENU.PLAYER_FIGHT) {
		if (!menu_executed_once) {
			battle_get_soul().visible = false;
			battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.PLAYER_FIGHT);
			menu_executed_once = true;
		}
	}
	else if (menu == BATTLE_MENU.ENEMY_DAMAGE) {
		if (!menu_executed_once) {
			battle_get_soul().visible = false;
			battle_set_next_menu(BATTLE_MENU.ENEMY_DEATH);
			
			battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.ENEMY_DAMAGE);
			menu_executed_once = true;
		}
	}
	else if (menu == BATTLE_MENU.ENEMY_DEATH) {
		if (!menu_executed_once) {
			battle_get_soul().visible = false;
			battle_set_next_state(BATTLE_STATE.TURN_PREPARATION);
			
			battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.ENEMY_DAMAGE_AFTERMATH);
			menu_executed_once = true;
		}
	}
}
else if (state == BATTLE_STATE.TURN_PREPARATION) {
	if (!state_executed_once) {
		battle_get_soul().visible = true;
		battle_execute_enemy_event(selection_enemy, ENEMY_EVENT.TURN_PREPARATION);
		state_executed_once = true;
	}
}