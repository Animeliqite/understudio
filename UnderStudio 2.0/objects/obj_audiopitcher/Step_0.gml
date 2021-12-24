/// @description Slowly change the pitch

if (currentPitch != targetPitch)
	music_set_pitch(audioStream, currentPitch);
else instance_destroy();