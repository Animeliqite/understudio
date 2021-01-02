with (obj_player) {
    if (x != xprevious) || (y != yprevious) {
        obj_encounterchooser.playerSteps++;
    }
}

if (playerSteps > playerStepsMax) {
    instance_create(0, 0, obj_encnotif);
    global.monster = encounterChances[irandom(array_length_1d(encounterChances) - 1)];
    playerSteps = 0;
    
    global.player_pos_x = obj_player.x;
    global.player_pos_y = obj_player.y;
    
    global.currentroom = room;
}

