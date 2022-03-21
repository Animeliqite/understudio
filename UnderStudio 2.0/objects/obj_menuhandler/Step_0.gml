/// @description Menu Functionality

switch (state) {
	case 0:
		// Choosing
		if (bt_up_p) selection = number_sub(selection, 0, 1);
		if (bt_down_p) selection = number_add(selection, 1, 1);
		
		// Confirmation
		if (bt_enter_p) {
			switch (prevSelection) {
				case 0: state = 1; break;
				case 1: state = 0.5; break;
			}
		}
		
		prevSelection = selection;
		break;
}