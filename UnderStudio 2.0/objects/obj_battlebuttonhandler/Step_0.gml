/// @description Functionality

// Initialize the local variables
var _bt = id;

// Check if the battle handler exists
if (instance_exists(obj_battlehandler)) {
	with (obj_battlehandler) {
		if (highlight_buttons && selection_button == _bt.buttonNo) {
			_bt.image_index = 1;
			
			obj_battleheart.x = _bt.x + _bt.heartXOffset;
			obj_battleheart.y = _bt.y + _bt.heartYOffset;
		}
		else {
			_bt.image_index = 0;
		}
	}
}