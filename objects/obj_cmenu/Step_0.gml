if (state == 0) {
    if (global.menu) || (global.cancel) {
        instance_destroy();
    }
}

if (global.down_press) && (state == 0) {
    sel[0]++;
    if (sel[0] > 2)
        sel[0] = 0;
    
    audio_play_sound(snd_menuswitch, 10, false);
}

if (global.up_press) && (state == 0) {
    sel[0]--;
    if (sel[0] < 0)
        sel[0] = 2;
    
    audio_play_sound(snd_menuswitch, 10, false);
}

