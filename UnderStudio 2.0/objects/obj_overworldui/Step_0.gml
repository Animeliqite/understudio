/// @description Functionality

var player = obj_player;
var playerExists = (instance_exists(player))
switch (state) {
	case -1:
		if (global.dxInterpreter.state != DiannexInterpreterState.Paused &&
			playerExists) player.canMoveDialogue = true;
		break;
	case 0:
		stateExecutedOnce = false;
		prevState = 0;
		if (playerExists) player.canMoveDialogue = false;
		if (!instance_exists(dialogueWriter)) {
			dialogueWriter = instance_create_depth(0, 0, 0, obj_textwriter);
			with (dialogueWriter) {
				text = obj_overworldui.dialogueText;
				voice = obj_overworldui.dialogueVoice;
				textSpeed = 0;
				drawText = false;
			}
		}
		else {
			if (dialogueWriter.completed) {
				global.dialogueInteractedTo.image_index = 0;
				dialogueFaceIndex = 0;
				if (BT_ENTER_P) {
					global.dxInterpreter.resumeScene();
					instance_destroy(dialogueWriter);
					dialogueCompleted = false;
					
					dialogueFaceIndex = 0;
					dialogueFace = undefined;
					if (global.dxInterpreter.state == DiannexInterpreterState.Inactive ||
						global.dxInterpreter.state == DiannexInterpreterState.Paused) {
						state = -1;
					}
				} else dialogueCompleted = true;
			}
			else {
				global.dialogueInteractedTo.image_index += 0.25;
				dialogueFaceIndex += 0.25;
				if (BT_SHIFT_P) {
					dialogueWriter.skipText = true;
				}
			}
		}
		break;
}