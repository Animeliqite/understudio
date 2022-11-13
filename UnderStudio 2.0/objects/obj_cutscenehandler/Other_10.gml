/// @description Execute Cutscene Action

if (!global.inCutscene) exit;
var scriptName = global.cutscene[global.currCutscenePhase][0];
var argumentArray = global.cutscene[global.currCutscenePhase][1];
for (var i = 0; i < array_length(scriptName); i++) {
	switch (array_length(argumentArray[i])) {
		case 0: script_execute(scriptName[i]); break;
		case 1: script_execute(scriptName[i], argumentArray[i][0]); break;
		case 2: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1]); break;
		case 3: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2]); break;
		case 4: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3]); break;
		case 5: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4]); break;
		case 6: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5]); break;
		case 7: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6]); break;
		case 8: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7]); break;
		case 9: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8]); break;
		case 10: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9]); break;
		case 11: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9], argumentArray[i][10]); break;
		case 12: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9], argumentArray[i][10], argumentArray[i][11]); break;
		case 13: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9], argumentArray[i][10], argumentArray[i][11], argumentArray[i][12]); break;
		case 14: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9], argumentArray[i][10], argumentArray[i][11], argumentArray[i][12], argumentArray[i][13]); break;
		case 15: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9], argumentArray[i][10], argumentArray[i][11], argumentArray[i][12], argumentArray[i][13], argumentArray[i][14]); break;
		case 16: script_execute(scriptName[i], argumentArray[i][0], argumentArray[i][1], argumentArray[i][2], argumentArray[i][3], argumentArray[i][4], argumentArray[i][5], argumentArray[i][6], argumentArray[i][7], argumentArray[i][8], argumentArray[i][9], argumentArray[i][10], argumentArray[i][11], argumentArray[i][12], argumentArray[i][13], argumentArray[i][14], argumentArray[i][15]); break;
	}
}