/// @description Initialize

// Inherit the parent event
event_inherited();

// Functions
cutsceneOnInteraction = function () {
	c_add_event(dialogue_simple, ["* This is merely a test.#* It's recommended to change it."]);
	cutsceneWaitForDialogueEnd();
}