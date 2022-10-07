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
	case 1:
		// Initialize the variables
		var charLength = string_length(namingLetters);
		
		// Adjust the sub states
		switch (subState) {
			case 0:
				var conditionDown = (selection == 19 || selection == 20);
				
				// Choosing
				if (BT_UP_P) selection = number_sub(selection, 0, namingRows);
				if (BT_DOWN_P) selection = number_add(selection, undefined, (conditionDown ? 7 : 0) + namingRows);
				if (BT_LEFT_P) selection = number_sub(selection, 0, 1);
				if (BT_RIGHT_P) selection = number_add(selection, undefined, 1);
				
				// Confirmation
				if (selection > charLength)  {
					selection -= 2;
					subState = 1;
				}
				break;
			case 1:
				var conditionUp = (selection == 31 || selection == 32);
				
				// Choosing
				if (BT_UP_P) selection = number_sub(selection, undefined, namingRows + (conditionUp ? 7 : 0));
				if (BT_DOWN_P) selection = number_add(selection, charLength * 2 - 1, namingRows);
				if (BT_LEFT_P) selection = number_sub(selection, undefined, 1);
				if (BT_RIGHT_P) selection = number_add(selection, charLength * 2 - 1, 1);
				
				// Confirmation
				if (selection < charLength) {
					selection += 2;
					subState = 0;
				}
				break;
		}
		break;
}