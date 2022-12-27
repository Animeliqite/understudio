/// @description Functionality

switch (state) {
	case -1:
		if (instance_exists(obj_player)) {
			obj_player.canMoveDialogue = true;
		}
		break;
	case 0:
		if (instance_exists(obj_player)) {
			obj_player.canMoveDialogue = false;
		}
		
		stateExecutedOnce = false;
		prevState = 0;
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
				dialogueFaceIndex = 0;
				if (BT_ENTER_P) {
					instance_destroy(dialogueWriter);
					dialogueCompleted = false;
					
					dialogueFaceIndex = 0;
					dialogueFace = undefined;
					state = -1;
				} else dialogueCompleted = true;
			}
			else {
				dialogueFaceIndex += 0.25;
				if (BT_SHIFT_P) {
					dialogueWriter.skipText = true;
				}
			}
		}
		break;
}