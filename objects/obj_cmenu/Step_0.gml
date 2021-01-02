if (menuno == 0) {
    if (input.menu) || (input.cancel) {
        instance_destroy();
    }
}

if (input.down_p) && (menuno == 0) {
    sel[0]++;
    if (sel[0] > 2)
        sel[0] = 0;
    
    audio_play_sound(snd_menuswitch, 10, false);
}

if (input.up_p) && (menuno == 0) {
    sel[0]--;
    if (sel[0] < 0)
        sel[0] = 2;
    
    audio_play_sound(snd_menuswitch, 10, false);
}

