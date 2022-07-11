/*// This script sets things up for the X order
function c_add_order(scriptToExecute, arguments) {
	var orderLength = array_length(global.cutsceneOrder);
	global.cutsceneOrder[orderLength][0] = scriptToExecute; // Set the script in the X order
	for (var n = 0; n < array_length(arguments); n++)
		global.cutsceneOrder[orderLength][n + 1] = arguments[n]; // Spread the arguments near the script of the X order
}

// This script changes things up for the X order
function c_change_order(orderNo, scriptToExecute, arguments) {
	global.cutsceneOrder[orderNo][0] = scriptToExecute; // Set the script in the X order
	for (var n = 0; n < array_length(arguments); n++)
		global.cutsceneOrder[orderNo][n + 1] = arguments[n]; // Spread the arguments near the script of the X order
}

// This script starts the cutscene
function c_begin() {
	global.cutscene = true; // Start the cutscene
}

// This script ends the cutscene
function c_end() {
	global.cutscene = false; // Stop the cutscene
	global.cutsceneOrder = []; // Reset the cutscene order
	
	// Reset the variables
	with (obj_cutscenehandler) {
		currentOrder = 0;
		sleepTimer = 0;
	}
}

// This script ends the current order and goes to the next one
function c_end_order() {
	with (obj_cutscenehandler) {
		if (currentOrder < array_length(global.cutsceneOrder) - 1) {
			currentOrder++;
			sleepTimer = 0;
			gotOnce = false;
		}
		else c_end();
	}
}

function c_sleep_until(object, event) {
	with (object) {
		if (event_type == event)
			c_end_order();
	}
}

// This script makes the cutscene wait for a certain amount of seconds (Used during cutscenes)
function c_sleep(seconds) {
	with (obj_cutscenehandler) {
		sleepTimer++;
		if (sleepTimer >= seconds * room_speed) c_end_order(); // Proceed to the next order
	}
}

// This script plays a sound with certain options (Used during cutscenes)
function c_play_sfx(soundid, volume = 1, pitch = 1, time = 0) {
	var snd = global.sfxManager.Play(soundid);
	
	audio_sound_gain(snd, 0, 0);
	audio_sound_gain(snd, volume, time * 1000);
	audio_sound_pitch(snd, pitch);
	c_end_order(); // Proceed to the next order
}

// This script changes the pitch of a sound ID
function c_tween_sfx_pitch(soundid, pitch = 1, duration = 0, tween = "linear", relative = false) {
	global.sfxManager.TweenPitch(soundid, pitch, duration, tween, relative);
	c_end_order();
}


// This script sets an instance's variable (Used during cutscenes)
function c_set_instance_variable(instance, variable, newValue) {
	variable_instance_set(instance, variable, newValue);
	c_end_order(); // Proceed to the next order
}

// This script initializes and plays a music from a filename
function c_play_music(fname, volume = 1, pitch = 1, time = 0) {
	var stream = global.musicManager.Load(fname);
	global.musicManager.Play(stream, volume, pitch, time);
	c_end_order();
}

// This script stops a music stream
function c_stop_music(stream) {
	global.musicManager.Unload(stream);
	c_end_order();
}

// This script changes the volume of a sound ID
function c_set_music_volume(soundid, volume = 1, time = 0) {
	global.musicManager.SetVolume(soundid, volume, time);
	c_end_order();
}

// This script create a writer
function c_run_text(_x, _y, text, color = c_white, voice = [snd_defaultvoice], draw = true, alpha = 1, scaleX = 1, scaleY = 1) {
	var inst = instance_create_depth(_x, _y, -1000, obj_textwriter);
	inst.text = text;
	inst.drawText = draw;
	inst.voice = voice;
	inst.color = color;
	inst.alpha = alpha;
	inst.scaleX = scaleX;
	inst.scaleY = scaleY;
	
	c_end_order();
}


// This script changes the pitch of a sound ID
function c_set_music_pitch(soundid, pitch = 1, duration = 0, tween = "linear", relative = false) {
	if (duration == 0)
		global.musicManager.SetPitch(soundid, pitch);
	else global.musicManager.TweenPitch(soundid, pitch, duration, tween, relative);
	c_end_order();
}

// This script creates an animation on an instance relatively to the variable's value (Used during cutscenes)
function c_execute_tween(instance, variable, targetValue, curveSubName = "linear", seconds = 1, relative = false) {
	execute_tween(instance, variable, targetValue, curveSubName, seconds, relative);
	c_end_order(); // End the order
}

function c_create_window_animation(effect = 0, intensity = 1, seconds = 1, posX = window_get_x(), posY = window_get_y()) {
	with (obj_cutscenehandler) {
		sleepTimer++; // Increase the timer each frame
		// Is the timer less than given amount of seconds?
		if (sleepTimer < seconds * room_speed) {
			// Create the animation for a few seconds
			global.windowManager.ExecuteTween(effect, intensity, posX, posY);
		}
		else c_end_order();
	}
}