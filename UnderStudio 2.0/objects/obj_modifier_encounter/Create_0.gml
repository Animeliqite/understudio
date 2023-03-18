/// @description Initialize

// VARIABLES
encounterList = [];											// The combination of possible encounters
encounterSteps = 300;										// Maximum frames of player movement to start encounters
encounterCurrSteps = 0;										// How much did the player move?
encounterSettings = { exc: true, quick: false, anim: true }	// Which settings will be triggered?

// FUNCTIONS
addEncounter = function (encounterID) {
	array_push(encounterList, encounterID);
}

encounterSettings = function (exc = true, quick = false, anim = true) {
	encounterSettings.exc = exc;
	encounterSettings.quick = quick;
	encounterSettings.anim = anim;
}