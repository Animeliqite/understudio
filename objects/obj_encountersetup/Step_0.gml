if (currentSteps > currentStepsMax) {
	var monster = encounters[irandom(array_length(encounters) - 1)];
	enc_start(monster, showBubble, animateSoul, progressQuick);
    currentSteps = 0;
	
    global.player_pos_x = obj_player.x;
    global.player_pos_y = obj_player.y;
}

