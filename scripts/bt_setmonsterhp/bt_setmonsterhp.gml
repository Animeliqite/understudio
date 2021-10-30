/// @description Sets the monster's HP.
/// @param monsterID
/// @param hp
/// @arg hp_max
function bt_setmonsterhp(){
	var monsterID = argument[0];
	var hp = argument[1];
	var hpMax = -1;
	
	if (argument_count > 2)
		var hpMax = argument[2];
	
	obj_battlemanager.monsterHP[monsterID] = hp;
	if (hpMax != -1)
		obj_battlemanager.monsterHPMax[monsterID] = hpMax;
}