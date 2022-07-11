function c_set_event(phase, scriptName, scriptArguments = []){
	array_push(global.cutscene[phase][0], scriptName);
	array_push(global.cutscene[phase][1], scriptArguments);
}

function c_add_event(scriptName, scriptArguments = []){
	array_push(global.cutscene[global.currCutscenePhase][0], scriptName);
	array_push(global.cutscene[global.currCutscenePhase][1], scriptArguments);
}

function c_prev_phase(){
	global.currCutscenePhase--;
}

function c_next_phase(){
	global.currCutscenePhase++;
}

function c_set_phase(phase){
	global.currCutscenePhase = phase;
}

function c_reset_phase(){
	global.currCutscenePhase = 0;
}