/// @description Moves the battle board.
var tween = [-1, -1, -1, -1];
function board_move(){
	tween[0] = TweenFire(obj_battlemanager, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed / 2, "boardX1", obj_battlemanager.boardX1, global.boardDestination[0]);
	tween[1] = TweenFire(obj_battlemanager, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed / 2, "boardY1", obj_battlemanager.boardY1, global.boardDestination[1]);
	tween[2] = TweenFire(obj_battlemanager, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed / 2, "boardX2", obj_battlemanager.boardX2, global.boardDestination[2]);
	tween[3] = TweenFire(obj_battlemanager, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed / 2, "boardY2", obj_battlemanager.boardY2, global.boardDestination[3]);
}

function board_is_moving(){
	return (TweenExists(tween[0]) && TweenExists(tween[1]) && TweenExists(tween[2]) && TweenExists(tween[3]))
}