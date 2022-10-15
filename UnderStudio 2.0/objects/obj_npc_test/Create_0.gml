/// @description Initialize

// Inherit the parent event
event_inherited();

// Functions
cutsceneOnInteraction = function () {
	c_add_event(show_message, ["test message"]);
	c_next_editing_phase(true);
	c_add_event(show_message, ["test message 2"]);
	c_next_editing_phase(true);
}