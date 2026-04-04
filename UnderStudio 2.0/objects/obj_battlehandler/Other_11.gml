/// @description Initialize Everything

// ENUMS
enum BATTLE_STATE {
	BUTTON,
	PLAYER_ACTION,
	DIALOGUE,
	TURN_PREPARATION,
	IN_TURN,
	TURN_END,
	RESULT,
	CUSTOM,
	NONE
}

enum BATTLE_STATE_CONDITION {
	TO_TURN
}

enum BATTLE_MENU {
	NONE,
	ENEMY_SELECTION,
	PLAYER_FIGHT,
	PLAYER_ACT,
	PLAYER_ITEM,
	PLAYER_MERCY,
	ENEMY_DAMAGE,
	ENEMY_DEATH
}

enum ENEMY_EVENT {
	PLAYER_FIGHT,
	PLAYER_SPARE,
	PLAYER_FLEE,
	ENEMY_DAMAGE,
	ENEMY_DAMAGE_AFTERMATH,
	TURN_PREPARATION,
	IN_TURN,
	TURN_END
}

enum BATTLE_BUTTON {
    FIGHT,
    ACT,
    ITEM,
    MERCY,
    _SIZE = 4 // A trick to get the number of buttons easily
}

battleEnemies = battle_retrieve_enemies();

instance_create_depth(32, 432, 0, obj_battlebutton_fight);	// The FIGHT button
instance_create_depth(185, 432, 0, obj_battlebutton_act);	// The ACT button
instance_create_depth(345, 432, 0, obj_battlebutton_item);	// The ITEM button
instance_create_depth(500, 432, 0, obj_battlebutton_mercy);	// The MERCY button
instance_create_depth(500, 432, 0, obj_battleboardhandler);	// The board handler
instance_create_depth(500, 432, 0, obj_battleuihandler);	// The UI handler
instance_create_depth(320, 240, -300, obj_battleheart);