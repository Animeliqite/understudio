// This script plays a sound on a specific emitter

function SFXUtil() constructor {
	Play = function (soundid) {
		return audio_play_sound_on(global.sfxEmitter, soundid, false, 8);
	}
	
	Stop = function (soundid) {
		return audio_stop_sound(soundid);
	}
	
	TweenPitch = function (soundid, pitch = 1, duration = 0, tween = "linear", relative = false) {
		with (instance_create_depth(0, 0, 0, obj_audiopitcher)) {
			audioStream = soundid;
			currentPitch = audio_sound_get_pitch(soundid);
			targetPitch = pitch;
			self.duration = duration;
			self.relative = relative;
			self.tween = tween;
		}
	}
}

function MusicUtil() constructor {
	// This script initializes an external music file and creates a stream
	Load = function (fname) {
		return audio_create_stream(global.musicFilePath + fname + ".ogg");
	}
	
	// This script deinitializes an external music file and destroys the stream
	Unload = function (streamid) {
		return audio_destroy_stream(streamid);
	}
	
	SetPitch = function (streamid, pitch = 1) {
		return audio_sound_pitch(streamid, pitch);
	}
	
	SetVolume = function (streamid, volume = 1, time = 0) {
		return audio_sound_gain(streamid, volume, time * 1000);
	}
	
	TweenPitch = function (streamid, pitch = 1, duration = 0, tween = "linear", relative = false) {
		with (instance_create_depth(0, 0, 0, obj_audiopitcher)) {
			audioStream = streamid;
			currentPitch = audio_sound_get_pitch(streamid);
			targetPitch = pitch;
			self.duration = duration;
			self.relative = relative;
			self.tween = tween;
		}
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