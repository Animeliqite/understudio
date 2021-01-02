if (phase == 0) {
    if (alpha < 1) {
        alpha += 0.1;
    }
    else {
        phase = 1;
        room_goto(targetRoom);
    }
}

if (phase == 1) {
    if (alpha > 0) {
        alpha -= 0.1;
    }
    else {
        instance_destroy();
    }
}

