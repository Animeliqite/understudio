/// @description Initialize

// Inherit the parent event
event_inherited();

// Functions
cutsceneOnInteraction = function () {
	c_set_player_moveable(cut, false);
	c_run_text(cut, "* Placeholder dialogue!", true);
	c_set_player_moveable(cut, true);
}