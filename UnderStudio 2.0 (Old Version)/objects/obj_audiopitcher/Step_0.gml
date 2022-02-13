/// @description Slowly change the pitch

if (currentPitch != targetPitch)
	global.musicManager.SetPitch(audioStream, currentPitch);
else instance_destroy();