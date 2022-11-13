/// @description Initialize

// General Settings
image_index	= 0;
image_speed	= 0;

// Advanced Settings
currDir = DIR_DOWN;

// Functions
cutsceneOnInteraction = function () {
	
}

cutsceneWaitForDialogueEnd = function () {
	c_next_editing_phase(obj_overworldui, "dialogueCompleted", true);
	c_add_event(c_event_empty);
	c_next_editing_phase("global", "inputConfirmPress", true);
}