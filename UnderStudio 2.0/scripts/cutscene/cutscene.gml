function c_set_event(phase, scriptName, scriptArguments = []){
	array_push(global.cutscene[phase][0], scriptName);
	array_push(global.cutscene[phase][1], scriptArguments);
}

function c_add_event(scriptName, scriptArguments = []){
	array_push(global.cutscene[global.currCutsceneEditingPhase][0], scriptName);
	array_push(global.cutscene[global.currCutsceneEditingPhase][1], scriptArguments);
}

function c_clear_event() {
	for (var i = 0; i < array_length(global.cutscene); i++)
		global.cutscene[i] = [[],[]];
}

function c_begin() {
	global.inCutscene = true;
	c_reset_phase();
}

function c_end() {
	global.inCutscene = false;
	c_reset_phase();
	c_clear_event();
}

function c_phase_wait(frames){
	global.cutsceneIncrementationWaitTime[global.currCutscenePhase] = frames;
}

function c_prev_editing_phase(){
	global.currCutsceneEditingPhase--;
}

function c_next_editing_phase(condition = undefined){
	global.cutsceneCondition[global.currCutsceneEditingPhase] = (condition);
	global.cutsceneExecutedFromObject[global.currCutsceneEditingPhase] = object_index;
	global.cutsceneConditionResult[global.currCutsceneEditingPhase] = "NEXT";
	global.currCutsceneEditingPhase++;
}

function c_set_editing_phase(phase, condition = undefined){
	global.cutsceneCondition[global.currCutsceneEditingPhase] = (condition);
	global.cutsceneExecutedFromObject[global.currCutsceneEditingPhase] = object_index;
	global.cutsceneConditionResult[global.currCutsceneEditingPhase] = "SET";
	global.cutsceneConditionResultAsSet[global.currCutsceneEditingPhase] = phase;
	global.currCutsceneEditingPhase = phase;
}

function c_prev_phase(){
	global.currCutscenePhase--;
	global.cutsceneWaitingForNextPhase = false;
}

function c_next_phase(){
	global.currCutscenePhase++;
	global.cutsceneWaitingForNextPhase = false;
}

function c_set_phase(phase){
	global.currCutscenePhase = phase;
	global.cutsceneWaitingForNextPhase = false;
}

function c_reset_phase(){
	global.currCutscenePhase = 0;
	global.currCutsceneEditingPhase = 0;
	global.cutsceneWaitingForNextPhase = false;
}