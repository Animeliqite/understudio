musicFile = global.musicManager.Load("alarm_titlescreen");
music = global.musicManager.Play(musicFile, 1, 1, 0);

c_add_order(c_sleep, [1]);
c_add_order(c_play_sfx, [snd_test, 1, 1, 0]);
c_add_order(c_execute_tween, [id, "image_xscale", 1, "easeIn", 1, false]);
c_add_order(c_execute_tween, [id, "image_yscale", 1, "easeOut", 1, false]);
c_begin();