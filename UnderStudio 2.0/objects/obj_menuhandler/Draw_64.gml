/// @description Draw necessary things

var w = display_get_gui_width(), h = display_get_gui_height(), sx = w / 640, sy = h / 480;
var gpConnected = gamepad_is_connected(0);
switch (state) {
	case 0:
		// Draw the instructions
		draw_ftext(170 * sx, 41 * sy, " --- Instruction ---", fnt_main, c_silver, 1, 1, 1, 0, fa_left, fa_top);
		draw_rpgtext(170 * sx, 102 * sy, (gpConnected ? "`sprite:button_z`" : "[Z or ENTER]") + " - Confirm", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170 * sx, 137 * sy, (gpConnected ? "`sprite:button_x`" : "[X or SHIFT]") + " - Cancel", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170 * sx, 172 * sy, (gpConnected ? "`sprite:button_c`" : "[C or CTRL]") + " - Menu (In-game)", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170 * sx, 207 * sy, "[F4] - Fullscreen", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170 * sx, 242 * sy, "[Hold ESC] - Quit", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170 * sx, 277 * sy, "When HP is 0, you lose.", fnt_main, 1, -1, -1, 1, 1, c_silver);
		
		// Draw the selectable texts
		draw_rpgtext(170 * sx, 345 * sy, "Begin Game", fnt_main, 1, -1, -1, 1, 1, selection == 0 ? c_yellow : c_white);
		draw_rpgtext(170 * sx, 385 * sy, "Settings", fnt_main, 1, -1, -1, 1, 1, selection == 1 ? c_yellow : c_white);
		
		draw_ftext(w / 2, 476 * sy, "UNDERTALE ENGINE v1.00 BY ANIMELIQITE 2021-2022", fnt_crypt, c_gray, 1, 0.5, 0.5, 0, fa_center, fa_bottom);
		break;
	case 1:
		
		break;
}