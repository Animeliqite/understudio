/// @description Cutscene Functionality

if (!paused) {
	processActions = true;
	while (processActions) {
		if(array_length(actions) > 0){
			if (variable_struct_exists(actions[0], "init") && !waitForInit) {
				waitForInit = true;
				actions[0].init();
			}
			if (!actions[0].update()) {
				while (array_length(actionsNew) > 0) {
					array_insert(actions, 1, array_pop(actionsNew));
				}
				array_delete(actions, 0, 1);
				waitForInit = false;
			} else processActions = false;
		}
		else {
			processActions = false;
			instance_destroy();
		}
	}
}