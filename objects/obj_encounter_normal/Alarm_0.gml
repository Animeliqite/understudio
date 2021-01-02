draw_soul = !draw_soul;
audio_play_sound(snd_enc1, 10, false);

phase++;

if (phase < 3) {
    alarm[0] = 4;
}

mus_pause(global.currentsong);

