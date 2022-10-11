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

draw_self();;