/// @description Initialize

enemyName = "Test Monster";
enemyHP = 100;
enemyHPMax = 100;
enemyDEF = 0;

enemyEvent = undefined;

enemyIdleSprite = undefined;
enemyHurtSprite = undefined;

damageTaken = 0;

enemyActions = {
	actionNames: ["Check", "Talk"],
	actionFuncIDs: [0, 1]
}

executeEnemyEvent = function (event) {
	enemyEvent = event;
	event_user(0);
}