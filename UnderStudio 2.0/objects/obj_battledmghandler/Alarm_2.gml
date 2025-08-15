/// @description Execute Tween

execute_tween(id, "dmgAmountAnim", 1, "linear", 15, false);

timer_set(function () {
	battle_set_menu(battle_get_next_menu());
}, 45, []);