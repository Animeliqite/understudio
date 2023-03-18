/// @description Functionality

// Check if the player exists
if (instance_exists(obj_player) && !encounter_is_active()) {
	// Initialize variables
	encounterCurrSteps = obj_player.stepsTaken;
	
	// Check if the current steps are bigger than the maximum steps
	if (encounterCurrSteps >= encounterSteps) {
		// Start the encounter
		encounter_start(
			obj_player,
			encounterList[irandom(array_length(encounterList) - 1)],
			encounterSettings.exc,
			encounterSettings.anim,
			encounterSettings.quick
		);
	}
}