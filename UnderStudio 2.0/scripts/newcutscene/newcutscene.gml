function c_add_event(order, scriptName, scriptArguments = []){
	array_push(global.cutscene[order][0], scriptName);
	array_push(global.cutscene[order][1], scriptArguments);
}