/// @description Initialize

/*

	This object handles all the cutscenes that play in an order.
	It includes its own handling scripts for easier programming.
	
	- c_add_event(scriptName, [argument0, argument1, ...]);
	This script above adds an action with the order being the last than the specified action before.
	Be warned that using an incompatible script (normally scripts without the "c_" at the start) will softlock the cutscene.
	
	- c_begin();
	This script above starts the cutscene. It is set to automatically end upon executing all the remaining orders.
	
	- c_end();
	This script above ends the cutscene.
	
	- c_phase_wait(frames);
	This script above starts the timer and waits for a specified amount of frames. After that, the current order goes to next.

*/

actions = [];
actionsNew = [];
waitForInit = false;
processActions = false;
paused = false;