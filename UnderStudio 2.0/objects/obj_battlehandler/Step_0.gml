/// @description Functionality

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
			sfx_play(snd_menuselect);
			selection = 0;
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
				
				break;
		}
		break;
}