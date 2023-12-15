/// @description Functionality

var _battle = obj_battlehandler;
if (BT_ENTER_P && !targetHitExecutedOnce) {
	var _enemy = _battle.battleEnemies[_battle.selection];
	var _sliceX = _enemy.x, _sliceY = _enemy.y - (_enemy.sprite_height / 2);
	
	instance_destroy(instance_find_equal_value(obj_animationhandler, "targetInstance", id));
	instance_create_depth(_sliceX, _sliceY, depth - 200, global.battleFightSliceObj);
	
	_enemy.damageTaken = targetDMG;
	
	alarm[0] = 60;
	targetHitExecutedOnce = true;
}

if (abs(x - barX) > abs(x - barX - 1))
	targetDMG -= 0.25;
else targetDMG += 0.25;