function battle_retrieve_enemies() {
	var _enemy = [];
	switch (global.encounterID) {
		case 0:
			_enemy = [
				instance_create_depth(320, 240, 0, obj_battle_enemy_test)
			];
			break;
	}
	return _enemy;
}

function battle_calculate_dmg(dmg) {
	return (global.playerAT + global.playerATWeapon + floor(median(10, global.playerHP._max, 90) - 10) / 10) * floor(dmg);
}