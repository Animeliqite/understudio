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