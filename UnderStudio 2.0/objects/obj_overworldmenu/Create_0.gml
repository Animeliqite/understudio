/// @description Initialize

active			= false;				// Is the menu active?
mainState		= 0;					// The current menu state
subState		= 0;					// The current menu substate (like in USE, INFO and DROP)
selection		= 0;					// The current selection
itemSelection	= 0;					// The current ITEM selection
itemEnabled		= false;				// Is the ITEM menu enabled?
cellEnabled		= true;					// Is the CELL menu enabled?
contactList		= ds_list_create();		// The list that we can make calls on
contactNameList	= ds_list_create();		// The list that we can make calls onitemEnabled