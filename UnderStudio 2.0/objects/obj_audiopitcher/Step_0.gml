/// @description Slowly change the pitch

if (currentPitch != targetPitch)
	Music.SetPitch(audioStream, currentPitch);
else instance_destroy();