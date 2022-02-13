/// @description Draw necessary things

var w = display_get_gui_width(), h = display_get_gui_height();
var gp_connected = gamepad_is_connected(0);
switch (state) {
	case 0:
		draw_ftext(170, 40, " -- Instructions --", fnt_main, c_silver, 1, 1, 1, 0, fa_left, fa_top);
		draw_rpgtext(170, 100, (gp_connected ? "`sZ`" : "[Z or ENTER]") + " - Confirm", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170, 140, (gp_connected ? "`sX`" : "[X or SHIFT]") + " - Cancel", fnt_main, 1, -1, -1, 1, 1, c_silver);
		draw_rpgtext(170, 180, (gp_connected ? "`sC`" : "[C or CTRL]") + " - Menu (In-game)", fnt_main, 1, -1, -1, 1, 1, c_silver);
		break;
}