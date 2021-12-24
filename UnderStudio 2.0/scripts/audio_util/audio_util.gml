// This script plays a sound on a specific emitter
function sfx_play(soundid) {
	return audio_play_sound_on(global.sfxEmitter, soundid, false, 8);
}

// This script initializes an external music file and creates a stream
function music_load(fname) {
	return audio_create_stream(global.musicFilePath + fname + ".ogg");
}

// This script deinitializes an external music file and destroys the stream
function music_unload(stream) {
	return audio_destroy_stream(stream);
}

// This script plays music from an audio stream
function music_play(stream, volume, pitch, volTargetTime) {
	var snd = audio_play_sound_on(global.songEmitter, stream, true, 10);
	audio_sound_gain(snd, 0, 0);
	audio_sound_gain(snd, volume, (!is_undefined(volTargetTime) ? volTargetTime * 1000 : 0));
	audio_sound_pitch(snd, pitch);
	return snd;
}

// This script checks if a stream is already playing
function music_is_playing(stream) {
	return audio_is_playing(stream);
}

// This script sets a stream's pitch
function music_set_pitch(stream, pitch) {
	audio_sound_pitch(stream, pitch);
}

// This script sets the volume of a sound ID
function music_set_volume(soundid, volume, time) {
	audio_sound_gain(soundid, volume, time * 1000);
}

// This script stops the music initialized from an audio stream
function music_stop(stream) {
	music_unload(stream);
}