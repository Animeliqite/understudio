var currentMonster = obj_battlemanager.monsters[bt_getcurrent_monster()];

if (global.confirm) {
	if (TweenIsPlaying(aimTween)) {
		TweenStop(aimTween);
		instance_create_depth(currentMonster.x, currentMonster.y, depth_battle.bullet, obj_playerattack_knife);
	}
}
else {
	if (TweenIsPlaying(aimTween)) {
		if (chances == 0) {
			if (aimX < global.boardX2 - ((global.boardX2 - global.boardX1) / 2))
				damageCalculation++;
			else
				damageCalculation--;
		}
		else {
			if (aimX > global.boardX1 + ((global.boardX2 - global.boardX1) / 2))
				damageCalculation++;
			else
				damageCalculation--;
		}
	}
}

if (done == true) {
    if (image_alpha > 0) {
        image_alpha -= 0.1;
		image_xscale -= 0.05;
    }
    else
        instance_destroy();
}