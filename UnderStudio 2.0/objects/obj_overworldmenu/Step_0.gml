/// @description Functionality

var u = BT_UP_P, d = BT_DOWN_P, l = BT_LEFT_P, r = BT_RIGHT_P; // Initialize the keys
itemEnabled = (ds_list_size(global.playerInventory) > 0);
 
// If the menu is not visible, then exit
if (!active) {
	mainState = 0;
	subState = 0;
	exit;
}

switch (mainState) {
	case 0: // ITEM, STAT and CELL
		// Selection functionality
		var prevSelection = selection;
		var maxSelection = (cellEnabled ? 2 : 1);
		
		if (u) selection = number_sub(selection, 0);
		if (d) selection = number_add(selection, maxSelection);
		
		// Play a sound upon choosing
		if (prevSelection != selection)
			sfx_play(snd_menumove);
		
		// Confirming and proceeding to the next state
		if (BT_ENTER_P) {
			switch (selection) {
				case 0:
					// Don't do anything if there are no items
					if (!itemEnabled)
						exit;
					
					mainState = 1;
					sfx_play(snd_menuselect);
					break;
				case 1:
					mainState = 2;
					sfx_play(snd_menuselect);
					break;
				case 2:
					mainState = 3;
					selection = 0;
					sfx_play(snd_menuselect);
					break;
			}
		}
		
		if (BT_SHIFT_P) {
			active = false;
			global.canmove = true;
		}
		break;
	case 1:
		switch (subState) {
			case 0:
				var prevSelection = selection;
				var maxSelection = ds_list_size(global.playerInventory) - 1;
				itemSelection = selection;
				
				// Selection functionality
				if (u) selection = number_sub(selection, 0);
				if (d) selection = number_add(selection, maxSelection);
				
				// Play a sound upon choosing
				if (prevSelection != selection) && (maxSelection > 0) {
					sfx_play(snd_menumove);
				}
				
				// Exiting to the main menu
				if (BT_SHIFT_P) {
					mainState = 0;
					selection = 0;
				}
				
				// Choosing an item
				if (BT_ENTER_P) {
					subState = 1;
					selection = 0;
					sfx_play(snd_menuselect);
				}
				break;
			case 1:
				var prevSelection = selection;
				var maxSelection = 2;
				
				if (l) selection = number_sub(selection, 0);
				if (r) selection = number_add(selection, maxSelection);
				
				// Play a sound upon choosing
				if (prevSelection != selection)
					sfx_play(snd_menumove);
				
				// Exiting from this sub state
				if (BT_SHIFT_P) {
					selection = itemSelection;
					subState = 0;
				}
				
				// Choosing an option
				if (BT_ENTER_P) {
					/*var item = item_get_id(itemSelection), info = item_get_info(item);
					var hp = info.hp, special = info.special, keyName = info.keyName;
					switch (selection) {
						case 0:
							global.textformat = [item_get_name(item), string(hp)];
							cutscene_create(json_array("owmenu.actions.item.use", global.cutscenejson));
							obj_cutscenehandler.sceneInfo[2] = [cutscene_run_text, "item.use.heal." + (hp < (global.playerhpmax - global.playerhp) ? "part" : "all")];
							if (global.playerhp < global.playerhpmax)
								global.playerhp = clamp(global.playerhp, global.playerhp + hp, global.playerhpmax);
							item_remove(itemSelection);
							break;
						case 1:
							global.textformat = [string(hp)];
							cutscene_create(json_array("owmenu.actions.item.info", global.cutscenejson));
							obj_cutscenehandler.sceneInfo[1] = [cutscene_run_text, "item.info." + keyName];
							break;
						case 2:
							global.textformat = [item_get_name(item)];
							cutscene_create(json_array("owmenu.actions.item.drop", global.cutscenejson));
							obj_cutscenehandler.sceneInfo[1] = [cutscene_run_text, "item.drop." + (!special ? string(irandom(4)) : "warn")];
							if (!special) item_remove(itemSelection);
							break;
					}*/
					subState = 2;
				}
				break;
			case 2:
				if (obj_overworldui.state == 0) && (!global.inCutscene) {
					selection = 0;
					active = false;
					global.canmove = true;
				}
				break;
		}
		break;
	case 2:
		if (BT_SHIFT_P)
			mainState = 0;
		break;
	case 3:
		if (subState == 0) {
			// Selection functionality
			var prevSelection = selection;
			var maxSelection = ds_list_size(contactList) - 1;
			if (u) selection = number_sub(selection, 0);
			if (d) selection = number_add(selection, maxSelection);
		
			// Play a sound upon choosing
			if (prevSelection != selection) && (maxSelection > 0)
				sfx_play(snd_menumove);
		
			// Exiting to the main menu
			if (BT_SHIFT_P) {
				mainState = 0;
				selection = 2;
			}
		
			// Calling someone from our contacts
			if (BT_ENTER_P) {
				//cutscene_create(json_array(ds_list_find_value(contactList, selection), global.cutscenejson));
				subState = 1;
			}
		}
		else {
			if (obj_overworldui.state == 0) && (!global.inCutscene) {
				selection = 2;
				active = false;
				global.canmove = true;
			}
		}
		break;
}