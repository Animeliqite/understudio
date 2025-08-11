/// @description Execute Tween

execute_tween(id, "hpOld", -dmgAmount, "linear", 15, true);

timer_set(function () {
	battle_set_menu(battle_get_next_menu());
}, 45, []);