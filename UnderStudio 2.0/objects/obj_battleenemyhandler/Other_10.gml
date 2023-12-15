/// @description Function ID

switch (executeFuncID) {
	case 0:
		instance_create_depth(0, 0, -2000, global.battleFightTargetObj);
		break;
	case 1:
		instance_create_depth(x, y - (sprite_height / 2) * image_yscale, -2000, obj_battledmghandler);
		break;
}