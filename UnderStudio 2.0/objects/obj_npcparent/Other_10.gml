/// @description Interaction

if (!global.inCutscene) {
	c_end();
	cutsceneOnInteraction();
	c_begin();
}