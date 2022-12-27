function c_execute_tween(cutsceneID, instance, variable, targetValue, curve = "linear", seconds = 1, relative = false, delay = 0) {
	execute_tween(instance, variable, targetValue, curve, seconds, relative, delay);
}

function c_create() {
	return instance_create_depth(0, 0, 0, obj_cutscenehandler);
}

function c_destroy(inst) {
	if(inst.object_index == obj_cutscenehandler)
		instance_destroy(inst);
}

function c_pause(inst) {
	inst.paused = true
}

function c_unpause(inst) {
	inst.paused = false;
}

function c_wait(inst, frames) {
	c_custom(inst, {
		frames: frames,
		update: function () {
			if (frames > 0) {
				frames--;
				return true;
			} else return false;
		}
	});
}

// ---------------------------------------
// Custom functions

function c_custom(inst, cutsceneStruct = { init: function () {}, update: function () {} }) {
	if (instance_exists(inst)) {
		with (inst) {
			array_push((processActions ? actionsNew : actions), cutsceneStruct);
		}
		
		return true;
	}
	else return false;
}

function c_run_text(inst, msg, wait = true, voice = [snd_defaultvoice], face = undefined, font = fnt_main) {
	c_custom(inst, {
		msg: msg,
		voice: voice,
		face: face,
		font: font,
		wait: wait,
		init: function () {
			dialogue_simple(msg, face, voice, font);
		},
		update: function () {
			if (wait) {
				if (obj_overworldui.dialogueCompleted && BT_ENTER_P) return false;
				else return true;
			} else return false;
		}
	});
}

function c_set_player_moveable(inst, moveable) {
	c_custom(inst, {
		moveable: moveable,
		init: function () {
			obj_player.canMove = moveable;
		},
		update: function () {
			return false;
		}
	});
}

function c_end(inst) {
	if (inst.object_index == obj_cutscenehandler)
		instance_destroy(inst);
}