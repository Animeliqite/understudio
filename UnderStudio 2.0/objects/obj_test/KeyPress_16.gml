if (!music_is_playing(mus)) {
	mus = music_load("spamton_battle");
	music_play(mus, 1, 0.95, 0);
}