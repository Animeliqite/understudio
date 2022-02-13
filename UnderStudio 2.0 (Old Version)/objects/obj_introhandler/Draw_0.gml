/// @description Draw stuff due events

draw_self();
switch (textNo) {
	case 11:
		if (fading) exit;
		if (finalPanelTimer == 0) {
			execute_tween(id, "finalPanelY", sprite_get_height(spr_intropanels_final) - 110, "linear", 7, true, 3);
			finalPanelTimer++;
		}
		draw_sprite_ext(spr_intropanels_final, 0, finalPanelX, finalPanelY, 1, 1, 0, c_white, image_alpha);
		break;
}

draw_set_color(c_black);
draw_rectangle(0, 0, 60, 240, false); // LEFT
draw_rectangle(260, 0, 320, 240, false); // RIGHT
draw_rectangle(0, 0, 320, 28, false); // TOP
draw_rectangle(0, 138, 320, 240, false); // BOTTOM