/// @description Functionality

// Initialize the local variables
var _bt = id;

// Check if the battle handler exists
if (instance_exists(obj_battlehandler)) {
	// Execute the code as the battle handler
	with (obj_battlehandler) {
		// Check if the button selection equals the button ID
		if (state == BATTLE_STATE_BUTTON && selection == _bt.buttonNo) {
			// Set the button image index
			_bt.image_index = 1;
			
			// Set the battle heart coordinates
			obj_battleheart.x = _bt.x + _bt.heartXOffset;
			obj_battleheart.y = _bt.y + _bt.heartYOffset;
		} else _bt.image_index = 0; // Reset the coordinates
	}
}