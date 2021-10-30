/// @description Sets the monster's name.
/// @param monsterID
/// @param newName
function bt_setmonstername(){
	var monsterID = argument[0];
	var newName = argument[1];
	
	obj_battlemanager.monsterNames[monsterID] = newName;
}