/// @description Destroy the instance
instance_destroy();
obj_battlemanager.menuno = -3;
obj_battlemanager.stateSelection = 0;
obj_battlemanager.monsterHP[bt_getcurrent_monster()] = newHP;
obj_attackmanager.attackStyle.done = true;
with (currentMonster)
	event_user(3);