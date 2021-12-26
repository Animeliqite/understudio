mus = Music.Load("spamton_battle");
musID = Music.Play(mus, 1, 0.95, 0);

c_add_order(c_sleep, [1]);
c_add_order(c_play_sfx, [snd_test, 1, 1, 0]);
c_add_order(c_execute_tween, [id, "image_xscale", 1, "easeIn", 1, false]);
c_add_order(c_execute_tween, [id, "image_yscale", 1, "easeOut", 1, false]);
c_add_order(c_sleep, [2]);
c_add_order(c_set_music_pitch, [musID, 1, 1]);
c_begin();