/// @description Functionality

var _battle = obj_battlehandler;
if (BT_ENTER_P && !targetHitExecutedOnce) {
	var _enemy = _battle.battleEnemies[_battle.selection];
	var _sliceX = _enemy.x, _sliceY = _enemy.y - (_enemy.sprite_height / 2);
	
	instance_destroy(instance_find_equal_value(obj_animationhandler, "targetInstance", id));
	instance_create_depth(_sliceX, _sliceY, depth - 200, global.battleFightSliceObj);
	
	alarm[0] = 60;
	targetHitExecutedOnce = true;
}

targetDMG = abs(x - barX);