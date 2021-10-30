switch (equippedWeapon) {
	default:
		attackStyle = obj_playertarget_knife;
		global.boardDestination = [32, 250, 602, 385];
		break;
}
instance_create_depth(room_width / 2, global.boardDestination[1] + ((global.boardDestination[3] - global.boardDestination[1]) / 2), depth_battle.bullet, attackStyle);
board_move();