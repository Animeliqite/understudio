/// @description Draw required stuff

switch (currDir) {
	case DIR_UP:
		sprite_index = spr_player_up;
		break;
	case DIR_DOWN:
		sprite_index = spr_player_down;
		break;
	case DIR_LEFT:
		sprite_index = spr_player_left;
		break;
	case DIR_RIGHT:
		sprite_index = spr_player_right;
		break;
}

var sprWidth = sprite_width, sprHeight = sprite_height;
if (BT_ENTER_P) {
	draw_set_color(c_red);
	draw_line(x, y, x, y - sprHeight + 5);
	draw_line(x, y, x, y + sprHeight - 5);
	draw_line(x, y, x - sprHeight + 5, y);
	draw_line(x, y, x + sprHeight - 5, y);
}

draw_self();;