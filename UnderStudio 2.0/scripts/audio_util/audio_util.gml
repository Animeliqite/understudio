// This script plays a sound on a specific emitter
function sfx_play(soundid) {
	return audio_play_sound_on(global.sfxEmitter, soundid, false, 8);
}

function MusicUtil() constructor {
	// This script initializes an external music file and creates a stream
	Load = function (fname) {
		return audio_create_stream(global.musicFilePath + fname + ".ogg");
	}
	
	// This script deinitializes an external music file and destroys the stream
	Unload = function (fname) {
		return audio_destroy_stream(fname);
	}
	
	SetPitch = function (fname, pitch = 1) {
		return audio_sound_pitch(fname, pitch);
	}
	
	SetVolume = function (fname, volume = 1, time = 0) {
		return audio_sound_gain(fname, volume, time * 1000);
	}
	
	Play = function (fname, volume = 1, pitch = 1, time = 0) {
		var snd = audio_play_sound_on(global.songEmitter, fname, true, 10);
		audio_sound_gain(snd, 0, 0);
		audio_sound_gain(snd, volume, time * 1000);
		audio_sound_pitch(snd, pitch);
		return snd;
	}
	
	CheckIfPlaying = function (fname) {
		return audio_is_playing(fname);
	}
}