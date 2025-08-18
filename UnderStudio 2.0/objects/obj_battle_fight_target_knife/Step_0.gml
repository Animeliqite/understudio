/// @description Functionality

var leftEdge  = bbox_left;
var rightEdge = bbox_right;

var maxDist = max(abs(x - leftEdge), abs(rightEdge - x));
if (maxDist <= 0) maxDist = 1;

var distance = abs(barX - x);
var accuracy = 1 - (distance / maxDist);
accuracy = clamp(accuracy, 0, 1);


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
	
	_battle.damage_accuracy = accuracy;
	
	alarm[0] = 60;
	targetHitExecutedOnce = true;
}