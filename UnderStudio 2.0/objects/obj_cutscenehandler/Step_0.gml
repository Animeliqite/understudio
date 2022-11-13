/// @description Cutscene Functionality

if (!global.inCutscene) exit;
if (array_length(global.cutscene[global.currCutscenePhase][0]) > 0) {
	var cutsceneConditionInst = global.cutsceneCondition[global.currCutscenePhase][0];
	var cutsceneConditionVar = (!global.cutsceneConditionIsGlobal[global.currCutscenePhase] ? variable_instance_get(cutsceneConditionInst, global.cutsceneCondition[global.currCutscenePhase][1]) : variable_global_get(global.cutsceneCondition[global.currCutscenePhase][1]));
	var cutsceneCondition = global.cutsceneCondition[global.currCutscenePhase][2];
	
	if (global.cutsceneCondition[global.currCutscenePhase] != undefined) {
		if (cutsceneConditionVar == cutsceneCondition) {
			if (global.cutsceneConditionResult[global.currCutscenePhase] == "NEXT")
				c_next_phase();
			else if (global.cutsceneConditionResult[global.currCutscenePhase] == "SET")
				c_set_phase(global.cutsceneConditionResultAsSet[global.currCutscenePhase]);
			global.cutsceneWaitingForConditionResult = false;
		}
		else {
			if (!global.cutsceneWaitingForConditionResult)  {
				event_user(0);
				global.cutsceneWaitingForConditionResult = true;
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