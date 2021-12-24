mus = Music.Load("spamton_battle");
musID = Music.Play(mus, 1, 0.95, 0);

cutscene_add_order(cutscene_sleep, [1]);
cutscene_add_order(cutscene_play_sfx, [snd_test, 1, 1, 0]);
cutscene_add_order(cutscene_create_instance_animation, [id, "image_xscale", 1, "easeIn", 1, false]);
cutscene_add_order(cutscene_create_instance_animation, [id, "image_yscale", 1, "easeOut", 1, false]);
cutscene_add_order(cutscene_sleep, [2]);
cutscene_add_order(cutscene_set_music_pitch, [musID, 1, 1]);
cutscene_begin();