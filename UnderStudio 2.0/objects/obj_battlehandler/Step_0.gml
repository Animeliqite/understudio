/// @description Functionality

var _board = obj_battleboardhandler;

switch (state) {
	case BATTLE_STATE_BUTTON:
		// Initialize the variables
		var _buttonNoOwner = instance_find_equal_value(obj_battlebuttonhandler, "buttonNo", selection);
		var _buttonSize = instance_number(obj_battlebuttonhandler) - 1;
		var _prevSelection = selection;
		
		// Check if those keys are pressed
		if (BT_RIGHT_P) selection = number_add(selection, _buttonSize);
		if (BT_LEFT_P) selection = number_sub(selection, 0);
		
		// Check if a button is pressed
		if (BT_ENTER_P) {
			state = BATTLE_STATE_ACTION;
			subState = _buttonNoOwner.buttonNo;
			selection = 0;
			
			sfx_play(snd_menuselect);
			instance_destroy(flavorWriter);
		}
		
		// Check if the previous selection is not the current selection
		if (_prevSelection != selection) {
			sfx_play(snd_menumove);
			_prevSelection = selection;
		}
		break;
	case BATTLE_STATE_ACTION:
		switch (subState) {
			case 0:
				switch (subSubState) {
					case 0:
						var _selectionSize = array_length(battleEnemies) - 1;
						var _prevSelection = selection;
				
						if (BT_UP_P) selection = number_sub(selection, 0);
						if (BT_DOWN_P) selection = number_add(selection, _selectionSize);
				
						if (BT_ENTER_P) {
							state = BATTLE_STATE_ACTION;
							subSubState = 1;
							selection = 0;
			
							sfx_play(snd_menuselect);
							instance_destroy(flavorWriter);
							flavorActionText = "";
						}
				
						var _str = "";
						for (var i = 0; i < _selectionSize + 1; i++) {
							_str += $"    * {battleEnemies[i].enemyName} #"
						}
						drawMenuText(_str);
						
						chosenEnemy = battleEnemies[selection];
						obj_battleheart.x = _board._x - _board.width + 40;
						obj_battleheart.y = _board._y - _board.height + 30 + (selection * 38);
						
						if (_prevSelection != selection) {
							sfx_play(snd_menumove);
							_prevSelection = selection;
						}
						break;
					case 1:
						chosenEnemy.executeFunction(0);
						subSubState = 1.1;
						break;
					case 2:
						chosenEnemy.executeFunction(1);
						subSubState = 2.1;
						break;
				}
				break;
		}
		break;
}