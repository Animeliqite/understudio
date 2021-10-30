// Sets the act options for the desired monster
/// @param monsterID
/// @param acts
function bt_setmonsteracts(){
	var monsterID = argument[0];
	var acts = argument[1];
	obj_battlemanager.battleMessages[1][monsterID] = acts;
}