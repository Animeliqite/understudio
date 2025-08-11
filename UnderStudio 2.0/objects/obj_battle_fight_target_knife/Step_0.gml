/// @description Functionality

var _battle = obj_battlehandler;
if (BT_ENTER_P && !targetHitExecutedOnce) {
	var _enemy = _battle.battleEnemies[_battle.selection_enemy];
	var _sliceX = _enemy.x, _sliceY = _enemy.y - (_enemy.sprite_height / 2);
	
	tween_destroy(id, "barX");
	instance_create_depth(_sliceX, _sliceY, depth - 200, global.battleFightSliceObj);
	
	// Timer for after the attack animation had been finished
	timer_set(function () {
		battle_set_menu(battle_get_next_menu());
	}, 35, []);
	
	_enemy.damageTaken = targetDMG;
	
	alarm[0] = 60;
	targetHitExecutedOnce = true;
}

if (abs(x - barX) > abs(x - barX - 1))
	targetDMG -= 0.25;
else targetDMG += 0.25;