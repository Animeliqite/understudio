/// @param monsterID
/// @param actID
/// @param message

function bt_setmonsteractresult(){
	var monsterID = argument[0];
	var actID = argument[1]
	
	var monsterName = obj_battlemanager.monsterNames[monsterID];
	var monsterAT = string(obj_battlemanager.monsterStats[bt_getcurrent_monster()][0]);
	var monsterDF = string(obj_battlemanager.monsterStats[bt_getcurrent_monster()][1]);
	var result = "* " + monsterName + " - AT " + monsterAT + " DF " + monsterDF + "`p1` &" + argument[2];
	
	obj_battlemanager.battleMessages[2][monsterID][actID] = result;
}