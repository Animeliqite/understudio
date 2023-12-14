/// @description Initialize

event_inherited();

enemyName	= "Test Monster";
enemyHP		= 100;
enemyHPMax	= 100;
enemyDEF	= 0;

enemyIdleSprite = spr_enemy_testmonster;
enemyHurtSprite = spr_enemy_testmonster_hurt;

enemyActions = {
	actionNames: ["Check", "Talk"],
	actionFuncIDs: [0, 1]
}

image_xscale = 2;
image_yscale = 2;