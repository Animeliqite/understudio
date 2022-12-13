/// @description Draw

// Exit if the menu is not active
if (!active)
	exit;

// Initialize the local variables
var yoff;
yoff = (camera_is_on_top() ? 0 : 271);

// Draw the rectangles
draw_box(32, yoff + 52, 173, yoff + 161, 6);
draw_box(32, 168, 173, 315, 6);

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_ftext(46, yoff + 61, global.playerName);
// LV
draw_ftext(46, yoff + 99, language_raw("owmenu.love"), fnt_crypt, c_white, 1, 0.5, 0.5);
draw_ftext(82, yoff + 99, string(global.playerLV), fnt_crypt, c_white, 1, 0.5, 0.5);

// HP
draw_ftext(46, yoff + 117, language_raw("owmenu.hp"), fnt_crypt, c_white, 1, 0.5, 0.5);
draw_ftext(82, yoff + 117, string(global.playerHP._curr) + "/" + string(global.playerHP._max), fnt_crypt, c_white, 1, 0.5, 0.5);

// GOLD
draw_ftext(46, yoff + 135, language_raw("owmenu.gold"), fnt_crypt, c_white, 1, 0.5, 0.5);
draw_ftext(82, yoff + 135, string(global.playerGold), fnt_crypt, c_white, 1, 0.5, 0.5);

if (!itemEnabled)
	draw_set_color(c_gray);
draw_ftext(84, 189, language_raw("owmenu.item"));
draw_set_color(c_white);
draw_ftext(84, 225, language_raw("owmenu.stat"));
if (cellEnabled)
	draw_ftext(84, 261, language_raw("owmenu.cell"));

switch (mainState) {
	case 0:
		// Draw the heart for indicating the selection
		draw_sprite_ext(spr_heartsmall, 0, 56, 196 + (36 * selection), 2, 2, 0, c_white, 1);
		break;
	case 1:
		if (subState != 2) {
			draw_box(188, 52, 533, 413, 6); // Initialize the box
			if (subState == 0)
				draw_sprite_ext(spr_heartsmall, 0, 208, 88 + (32 * selection), 2, 2, 0, c_white, 1); // Draw the heart for indicating the selection
			else if (subState == 1)
				draw_sprite_ext(spr_heartsmall, 0, 208 + (selection == 1 ? 96 : (selection == 2 ? 210 : 0)), 368, 2, 2, 0, c_white, 1); // Draw the heart for indicating the selection
			
			draw_set_color(c_white);
			for (var i = 0; i < ds_list_size(global.playerInventory); i++)
				draw_ftext(232, 80 + (32 * i), item_get_name(ds_list_find_value(global.playerInventory, i)));
			// Item actions
			draw_ftext(232, 360, language_raw("owmenu.actions.use"));
			draw_ftext(328, 360, language_raw("owmenu.actions.info"));
			draw_ftext(442, 360, language_raw("owmenu.actions.drop"));
		}
		break;
	case 2:
		var weapon = weapon_get_info(global.playerWeapon);
		var armor = armor_get_info(global.playerArmor);
		
		draw_box(188, 52, 533, 469, 6); // Initialize the box
		draw_ftext(216, 85, "\"" + global.playerName + "\"");
		draw_ftext(216, 145, language_raw("owmenu.love") + "  " + string(global.playerLV));
		draw_ftext(216, 177, language_raw("owmenu.hp") + "  " + string(global.playerHP._curr) + " / " + string(global.playerHP._max));
		
		draw_ftext(216, 241, language_raw("owmenu.at") + "  " + string(global.playerAT - 10) + " (" + string(ceil(weapon.strength)) + ")");
		draw_ftext(384, 241, language_raw("owmenu.exp") + ": " + string(global.playerEXP));
		
		draw_ftext(216, 273, language_raw("owmenu.df") + "  " + string(global.playerDF - 10) + " (" + string(ceil(armor.strength)) + ")");
		draw_ftext(384, 273, language_raw("owmenu.next") + ": " + string(global.playerNEXT));
		
		draw_ftext(216, 333, language_raw("owmenu.weapon") + ": " + string(weapon_get_name(global.playerWeapon)));
		draw_ftext(216, 365, language_raw("owmenu.armor") + ": " + string(armor_get_name(global.playerArmor)));
		draw_ftext(216, 405, language_raw("owmenu.gold_alt") + ": " + string(global.playerGold));
		break;
	case 3:
		if (subState == 0) {
			draw_box(188, 52, 533, 321, 6); // Initialize the box
			draw_sprite_ext(spr_heartsmall, 0, 208, 88 + (32 * selection), 2, 2, 0, c_white, 1); // Draw the heart for indicating the selection
		
			for (var i = 0; i < ds_list_size(contactList); i++)
				draw_ftext(232, 80 + (32 * i), ds_list_find_value(contactNameList, i));
		}
		break;
}