/// @description Functionality

var player = obj_player;
var playerExists = (instance_exists(player))
switch (state) {
	case -1:
		// Check if there's an ongoing Diannex scene and the player exists
		if (!dx_is_active() && playerExists)
			player.canMoveDialogue = true;
		break;
	case 0:
		// Set the code execution checker to false
		stateExecutedOnce = false;
		
		// Set the previous state to 0
		prevState = 0;
		
		// Check if the player exists
		if (playerExists) player.canMoveDialogue = false;
		
		// Check if the dialogue writer doesn't exist
		if (!instance_exists(dialogueWriter)) {
			// Create the dialogue writer
			dialogueWriter = instance_create_depth(0, 0, 0, obj_textwriter);
			with (dialogueWriter) {
				// Set the dialogue text
				text = obj_overworldui.dialogueText;
				
				// Set the dialogue voice
				voice = obj_overworldui.dialogueVoice;
				
				// Set the dialogue text speed
				textSpeed = 0;
				
				// Set drawing text to true
				drawText = false;
			}
		}
		else {
			// Check if the writer is completed
			if (dialogueWriter.completed) {
				// Reset the NPC's image index the player has interacted with
				global.dialogueInteractedTo.image_index = 0;
				
				// Reset the dialogue face image index
				dialogueFaceIndex = 0;
				
				// Check if the CONFIRM key is pressed
				if (BT_ENTER_P) {
					// Resume the Diannex Scene
					global.dxInterpreter.resumeScene();
					
					// Destroy the writer
					instance_destroy(dialogueWriter);
					
					// Set the dialogue completion checker to false
					dialogueCompleted = false;
					
					// Reset the dialogue face sprite index
					dialogueFace = undefined;
					
					// Check if there's an ongoing Diannex scene
					if (!dx_is_active() || dx_is_paused()) {
						state = -1;
					}
				} else {
					// Set the dialogue completion checker to true
					dialogueCompleted = true;
				}
			}
			else {
				// Increase the NPC's image index the player has interacted with
				global.dialogueInteractedTo.image_index += 0.25;
				
				// Increase the dialogue face image index
				dialogueFaceIndex += 0.25;
				
				// Check if CANCEL key is pressed
				if (BT_SHIFT_P) {
					// Skip the dialogue text
					dialogueWriter.skipText = true;
				}
			}
		}
		break;
}