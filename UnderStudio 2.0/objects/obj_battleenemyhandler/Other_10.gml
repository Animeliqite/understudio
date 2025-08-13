/// @description Enemy Events

var _obj = id;
switch (enemyEvent) {
	case ENEMY_EVENT.PLAYER_FIGHT:
		break;
	case ENEMY_EVENT.ENEMY_DAMAGE:
		break;
	case ENEMY_EVENT.ENEMY_DAMAGE_AFTERMATH:
		timer_set(function () {
			battle_set_state(battle_get_next_state());
		}, 45, []);
		break;
	case ENEMY_EVENT.TURN_PREPARATION:
		break;
}