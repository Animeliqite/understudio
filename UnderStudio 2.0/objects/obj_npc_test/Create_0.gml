/// @description Initialize

// Inherit the parent event
event_inherited();

// Functions
cutsceneOnInteraction = function () {
	c_add_event(dialogue_simple, ["* Testing lmfao", spr_face_placeholder_normal]);
	c_next_editing_phase(obj_overworldui, "dialogueCompleted", true);
	c_add_event(c_event_empty, [true]);
	c_next_editing_phase("global", "inputConfirmPress", true);
	c_add_event(dialogue_simple, ["* Testing lmfao 2", spr_face_placeholder_normal]);
	c_next_editing_phase(obj_overworldui, "dialogueCompleted", true);
	c_add_event(c_event_empty, [true]);
	c_next_editing_phase("global", "inputConfirmPress", true);
}