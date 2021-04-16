if (currentSteps > currentStepsMax) {
	var monster = encounters[irandom(array_length(encounters) - 1)];
	enc_start(monster, showBubble, animateSoul, progressQuick);
    currentSteps = 0;
	
    global.playerX = obj_player.x;
    global.playerY = obj_player.y;
}

