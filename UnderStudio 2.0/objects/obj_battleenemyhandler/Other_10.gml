/// @description Function ID

var _obj = id;
switch (executeFuncID) {
	case 0:
		instance_create_depth(0, 0, -2000, global.battleFightTargetObj);
		break;
	case 1:
		with (instance_create_depth(x, y - (sprite_height / 2), -2000, obj_battledmghandler)) {
			dmgAmount = battle_calculate_dmg(_obj.damageTaken);
			hpOld = _obj.enemyHP;
		}
		enemyHP -= battle_calculate_dmg(_obj.damageTaken);
		break;
}