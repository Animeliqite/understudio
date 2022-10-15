/// @description Execute Cutscene Action

if (!global.inCutscene) exit;
var scriptName = global.cutscene[global.currCutscenePhase][0];
var argumentArray = global.cutscene[global.currCutscenePhase][1];
for (var i = 0; i < array_length(scriptName); i++) {
	switch (array_length(argumentArray)) {
		case 0: script_execute(scriptName[i]); break;
		case 1: script_execute(scriptName[i], argumentArray[0][i]); break;
		case 2: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i]); break;
		case 3: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i]); break;
		case 4: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i]); break;
		case 5: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i]); break;
		case 6: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i]); break;
		case 7: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i]); break;
		case 8: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i]); break;
		case 9: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i]); break;
		case 10: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i]); break;
		case 11: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i], argumentArray[10][i]); break;
		case 12: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i], argumentArray[10][i], argumentArray[11][i]); break;
		case 13: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i], argumentArray[10][i], argumentArray[11][i], argumentArray[12][i]); break;
		case 14: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i], argumentArray[10][i], argumentArray[11][i], argumentArray[12][i], argumentArray[13][i]); break;
		case 15: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i], argumentArray[10][i], argumentArray[11][i], argumentArray[12][i], argumentArray[13][i], argumentArray[14][i]); break;
		case 16: script_execute(scriptName[i], argumentArray[0][i], argumentArray[1][i], argumentArray[2][i], argumentArray[3][i], argumentArray[4][i], argumentArray[5][i], argumentArray[6][i], argumentArray[7][i], argumentArray[8][i], argumentArray[9][i], argumentArray[10][i], argumentArray[11][i], argumentArray[12][i], argumentArray[13][i], argumentArray[14][i], argumentArray[15][i]); break;
	}
}