/// @description Menu Functionality

switch (state) {
	case 0: // Main Menu
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
	case 1: // Naming System
		// Initialize the variables
		var charLength = string_length(namingLetters);
		
		if (subState == 0 || subState == 1) {
			if (BT_ENTER_P) {
				if (string_length(namingName) < 6)
					namingName += string_char_at((subState == 0 ? string_upper(namingLetters) : string_lower(namingLetters)), (subState == 0 ? selection : selection - charLength) + 1);
			}
			if (BT_SHIFT_P) {
				if (string_length(namingName) > 0)
					namingName = string_delete(namingName, string_length(namingName), 1);
				else {
					state = 0;
					subState = 0;
					selection = 0;
				}
			}
		}
		
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
				
				prevSelection = selection;
				break;
			case 1:
				var conditionUp = (selection == 31 || selection == 32);
				prevSelection = selection;
				
				// Choosing
				if (BT_UP_P) selection = number_sub(selection, undefined, namingRows + (conditionUp ? 7 : 0));
				if (BT_LEFT_P) selection = number_sub(selection, undefined, 1);
				if (BT_RIGHT_P) selection = number_add(selection, charLength * 2 - 1, 1);
				
				if (BT_DOWN_P) {
					if (selection >= 45 && selection <= 46) {
						selection = 2;
						subState = 2;
					}
					else if (selection >= 47 && selection <= 48) {
						selection = 0;
						subState = 2;
					}
					else if (selection >= 49 && selection <= 51) {
						selection = 1;
						subState = 2;
					}
					else {
						selection = number_add(selection, charLength * 2 - 1, namingRows);
					}
				}
				
				// Bug-fixes
				if (selection > 2 && selection < charLength) {
					selection += 2;
					subState = 0;
				}
				break;
			case 2:
				if (BT_LEFT_P) selection = number_sub(selection, 0);
				if (BT_RIGHT_P) selection = number_add(selection, 2);
				if (BT_UP_P || BT_DOWN_P) {
					switch (selection) {
						case 0: selection = 47; break;
						case 1: selection = 49; break;
						case 2: selection = 45; break;
					}
					subState = 1;
				}
				
				// Confirmation
				if (BT_ENTER_P) {
					switch (selection) {
						case 0: state = 0; subState = 0; selection = 0; break;
						case 1: namingName = string_delete(namingName, string_length(namingName), 1); break;
						case 2:
							if (string_length(namingName) > 0) {
								state = 2;
								subState = 0;
								selection = 0;
							}
							break;
					}
				}
				break;
		}
		break;
	case 2:
		
		break;
}