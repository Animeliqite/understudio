/// @description  scr_encounter(monsterNo, anim, notif);
/// @param monsterNo
/// @param  anim
/// @param  notif
function scr_encounter(argument0, argument1, argument2) {

	var monsterNo = argument0;
	var anim = argument1;
	var notif = argument2;

	instance_create(0, 0, obj_encounter_normal);

	global.monster = monsterNo;



}
