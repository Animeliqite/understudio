/// @description Cutscene Functionality

if (!global.inCutscene) exit;

var cutsceneObject = id;
if (array_length(global.cutscene[global.currCutscenePhase][0]) > 0) {
	if (global.cutsceneCondition[global.currCutscenePhase] != (undefined)) {
		with (global.cutsceneExecutedFromObject[global.currCutscenePhase]) {
			if (global.cutsceneCondition[global.currCutscenePhase]) {
				with (cutsceneObject) {
					event_user(0);
					if (global.cutsceneConditionResult[global.currCutscenePhase] == "NEXT")
						c_next_phase();
					else if (global.cutsceneConditionResult[global.currCutscenePhase] == "SET")
						c_set_phase(global.cutsceneConditionResultAsSet[global.currCutscenePhase]);
				}
			}
		}
	}
	else {
		if (!global.cutsceneWaitingForNextPhase) {
			if (alarm[0] < 0)
				alarm[0] = max(1, global.cutsceneIncrementationWaitTime[global.currCutscenePhase]);
			global.cutsceneWaitingForNextPhase = true;
		}
	}
} else c_end();