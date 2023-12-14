/// @description Initialize Everything

// MACROS
#macro BATTLE_STATE_BUTTON 0
#macro BATTLE_STATE_ACTION 1
#macro BATTLE_STATE_DIALOGUE 2
#macro BATTLE_STATE_TURN_PREPARATION 3
#macro BATTLE_STATE_IN_TURN 4
#macro BATTLE_STATE_TURN_END 5
#macro BATTLE_STATE_RESULT 6
#macro BATTLE_STATE_CUSTOM 7

battleEnemies = battle_retrieve_enemies();

instance_create_depth(32, 432, 0, obj_battlebutton_fight);	// The FIGHT button
instance_create_depth(185, 432, 0, obj_battlebutton_act);	// The ACT button
instance_create_depth(345, 432, 0, obj_battlebutton_item);	// The ITEM button
instance_create_depth(500, 432, 0, obj_battlebutton_mercy);	// The MERCY button
instance_create_depth(500, 432, 0, obj_battleboardhandler);	// The board handler
instance_create_depth(500, 432, 0, obj_battleuihandler);	// The UI handler
instance_create_depth(320, 240, -300, obj_battleheart);