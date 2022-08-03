/// @description Menu Functionality

switch (state) {
	case 0:
		// Choosing
		if (BT_UP_P) selection = number_sub(selection, 0, 1);
		if (BT_DOWN_P) selection = number_add(selection, 1, 1);
		
		// Confirmation
		if (BT_ENTER_P) {
			switch (prevSelection) {
				case 0: state = 1; break;
				case 1: state = 0.5; break;
			}
		}
		
		prevSelection = selection;
		break;
	case 0.5:
		break;
}