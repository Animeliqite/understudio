/// @description Initialize

enemyName	= "Test Monster";
enemyHP		= 100;
enemyHPMax	= 100;
enemyDEF	= 0;

executeFuncID = -1;

enemyIdleSprite = undefined;
enemyHurtSprite = undefined;

enemyActions = {
	actionNames: ["Check", "Talk"],
	actionFuncIDs: [0, 1]
}

executeFunction = function (functionID) {
	executeFuncID = functionID;
	event_user(0);
}