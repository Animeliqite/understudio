// This script plays a sound on a specific emitter.
function sfx_play(soundid, pitch = 1, volume = 1, offset = 0) {
	return audio_play_sound_on(global.sfxEmitter, soundid, false, 8, volume, offset, pitch);
}

// This script stops a sound.
function sfx_stop(soundid) {
	return audio_stop_sound(soundid);
}

// This script animates a sound's pitch.
function sfx_animate_pitch(soundid, pitch = 1, duration = 0, tween = "linear", relative = false) {
	with (instance_create_depth(0, 0, 0, obj_audiopitcher)) {
		audioStream = soundid;
		currentPitch = audio_sound_get_pitch(soundid);
		targetPitch = pitch;
		self.duration = duration;
		self.relative = relative;
		self.tween = tween;
	}
}

// This script initializes an external music file and creates a stream
function song_load(fname) {
	return audio_create_stream(global.musicFilePath + fname + ".ogg");
}
	
// This script deinitializes an external music file and destroys the stream
function song_stop(streamid) {
	return audio_destroy_stream(streamid);
}
	
// This script sets the song's pitch.
function song_set_pitch(streamid, pitch = 1) {
	return audio_sound_pitch(streamid, pitch);
}

// This script sets the song's volume.
function song_set_volume(streamid, volume = 1, time = 0) {
	return audio_sound_gain(streamid, volume, time * 1000);
}

// This script animates the song's pitch.
function song_animate_pitch(streamid, pitch = 1, duration = 0, tween = "linear", relative = false) {
	with (instance_create_depth(0, 0, 0, obj_audiopitcher)) {
		audioStream = streamid;
		currentPitch = audio_sound_get_pitch(streamid);
		targetPitch = pitch;
		self.duration = duration;
		self.relative = relative;
		self.tween = tween;
	}
}

// This script makes the song play.
function song_play(fname, volume = 1, pitch = 1, time = 0) {
	var snd = audio_play_sound_on(global.songEmitter, fname, true, 10);
	audio_sound_gain(snd, 0, 0);
	audio_sound_gain(snd, volume, time * 1000);
	audio_sound_pitch(snd, pitch);
	return snd;
}

// This song check if the song is playing.
function song_is_playing(fname) {
	return audio_is_playing(fname);
}