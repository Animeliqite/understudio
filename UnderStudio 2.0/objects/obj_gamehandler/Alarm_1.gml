/// @description Decrease waiting timer

// Diannex waiting timer
if (dxWaitTimer > 0) {
	alarm[1] = 1;
	global.dxInterpreter.pauseScene();
	dxWaitTimer--;
}
else {
	if (dxWaitCondition || dxWaitCondition == undefined) {
		global.dxInterpreter.resumeScene();
	} else alarm[1] = 1;
}