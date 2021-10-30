/// @description Sets the basic statistics of the monster.
/// @param monsterID
/// @param atk
/// @arg def
/// @arg gold
/// @arg exp
function bt_setmonsterstats(){
	var monsterID = argument[0];
	var attack = argument[1];
	var defense = 0;
	var gold = 0;
	var xp = 0;
	
	if (argument_count > 2)
		defense = argument[2];
	
	if (argument_count > 3)
		gold = argument[3];
	
	if (argument_count > 4)
		xp = argument[4];
	
	obj_battlemanager.monsterStats[monsterID] = [attack, defense];
	obj_battlemanager.monsterRewards[monsterID] = [xp, gold]
}