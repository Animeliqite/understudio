// This script sets things up for the X order
function cutscene_add_order(scriptToExecute, arguments) {
	var orderLength = array_length(global.cutsceneOrder);
	global.cutsceneOrder[orderLength][0] = scriptToExecute; // Set the script in the X order
	for (var n = 0; n < array_length(arguments); n++)
		global.cutsceneOrder[orderLength][n + 1] = arguments[n]; // Spread the arguments near the script of the X order
}

// This script changes things up for the X order
function cutscene_add_order(orderNo, scriptToExecute, arguments) {
	global.cutsceneOrder[orderNo][0] = scriptToExecute; // Set the script in the X order
	for (var n = 0; n < array_length(arguments); n++)
		global.cutsceneOrder[orderNo][n + 1] = arguments[n]; // Spread the arguments near the script of the X order
}

// This script starts the cutscene
function cutscene_begin() {
	global.cutscene = true; // Start the cutscene
}

// This script ends the cutscene
function cutscene_end() {
	global.cutscene = false; // Stop the cutscene
	global.cutsceneOrder = []; // Reset the cutscene order
	
	// Reset the variables
	with (obj_cutscenehandler) {
		currentOrder = 0;
		sleepTimer = 0;
	}
}

// This script ends the current order and goes to the next one
function cutscene_end_order() {
	with (obj_cutscenehandler) {
		if (currentOrder < array_length(global.cutsceneOrder) - 1) {
			currentOrder++;
			sleepTimer = 0;
			gotOnce = false;
		}
		else cutscene_end();
	}
}


// This script makes the cutscene wait for a certain amount of seconds (Used during cutscenes)
function cutscene_sleep(seconds) {
	with (obj_cutscenehandler) {
		sleepTimer++;
		if (sleepTimer >= seconds * room_speed) cutscene_end_order(); // Proceed to the next order
	}
}

// This script plays a sound with certain options (Used during cutscenes)
function cutscene_play_sfx(soundid, volume = 1, pitch = 1, time = 0) {
	var snd = sfx_play(soundid);
	
	audio_sound_gain(snd, 0, 0);
	audio_sound_gain(snd, volume, time * 1000);
	audio_sound_pitch(snd, pitch);
	cutscene_end_order(); // Proceed to the next order
}

// This script sets an instance's variable (Used during cutscenes)
function cutscene_set_instance_variable(instance, variable, newValue) {
	variable_instance_set(instance, variable, newValue);
	cutscene_end_order(); // Proceed to the next order
}

// This script initializes and plays a music from a filename
function cutscene_play_music(fname, volume = 1, pitch = 1, time = 0) {
	var stream = music_load(fname);
	music_play(stream, volume, pitch, time);
	cutscene_end_order();
}

// This script stops a music stream
function cutscene_stop_music(stream) {
	music_stop(stream);
	cutscene_end_order();
}

// This script changes the volume of a sound ID
function cutscene_set_music_volume(soundid, volume = 1, volTargetTime = 0) {
	music_set_volume(soundid, volume, volTargetTime);
	cutscene_end_order();
}


// This script changes the pitch of a sound ID
function cutscene_set_music_pitch(soundid, pitch = 1, duration = 0, tween = "linear", relative = false) {
	if (duration == 0)
		music_set_pitch(soundid, pitch);
	else {
		with (instance_create_depth(0, 0, 0, obj_audiopitcher)) {
			audioStream = soundid;
			currentPitch = audio_sound_get_pitch(soundid);
			targetPitch = pitch;
			self.duration = duration;
			self.relative = relative;
			self.tween = tween;
		}
	}
	cutscene_end_order();
}

// This script creates an animation on an instance relatively to the variable's value (Used during cutscenes)
function cutscene_create_instance_animation(instance, variable, targetValue, curveSubName = "linear", seconds = 1, relative = false) {
	create_instance_animation(instance, variable, targetValue, curveSubName, seconds, relative);
	cutscene_end_order(); // End the order
}

function cutscene_create_window_animation(effect = 0, intensity = 1, seconds = 1, posX = window_get_x(), posY = window_get_y()) {
	with (obj_cutscenehandler) {
		sleepTimer++; // Increase the timer each frame
		// Is the timer less than given amount of seconds?
		if (sleepTimer < seconds * room_speed) {
			// Create the animation for a few seconds
			window_create_animation(effect, intensity, posX, posY);
		}
		else cutscene_end_order();
	}
}