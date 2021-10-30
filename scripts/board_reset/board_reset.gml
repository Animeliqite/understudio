/// @description Resets the battle board.
function board_reset(){
	global.boardDestination = [32, 250, 602, 385];
	board_move();
}