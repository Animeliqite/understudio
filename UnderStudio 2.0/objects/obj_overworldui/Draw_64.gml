/// @description Draw the user interface

// Initialize the variables
var cam = obj_camerahandler;

// Check if the dialogue box position checking is automated
if (dialogueIsOnTop == undefined && instance_exists(cam.currTarget))
	dialogueAlignY = cam.posCenterY > cam.currTarget.y ? 310 : 0;
else dialogueAlignY = dialogueIsOnTop ? 0 : 310;

// Function to draw the dialogue box
drawDialogueBox = function () {
	// Draw the dialogue box
	draw_box(32, 10 + dialogueAlignY, 608, 160 + dialogueAlignY);
	
	// Draw the dialogue face if there's one used
	if (dialogueFace != undefined)
		draw_sprite_ext(dialogueFace, dialogueFaceIndex, 100, 75 + dialogueAlignY, 2, 2, 0, c_white, 1);
}

switch (state) {
	case -1:
		// Check if the previous state is 0
		if (prevState == 0) {
			// Set the previous state to -1
			prevState = -1;
			
			// Check if the state is not executed once
			if (!stateExecutedOnce) {
				// Draw the dialogue box
				drawDialogueBox();
				
				// Set the state code execution checker to true
				stateExecutedOnce = true;
			}
		}
		break;
	case 0:
		if (!dialogueBattle) {
			// Draw the dialogue box
			drawDialogueBox();
		}
		
		// Check if the dialogue writer exists
		if (instance_exists(dialogueWriter)) {
			if (dialogueBattle) {
				if (instance_exists(obj_battleboardhandler))
					draw_rpgtext(obj_battleboardhandler._x - obj_battleboardhandler.width + 20 + (dialogueFace != undefined ? 118 : 0), obj_battleboardhandler._y - obj_battleboardhandler.height + 20, dialogueWriter.written, dialogueFont, 1, global.mainFontWidth, global.mainFontHeight, 1, 1, c_white);
			}
			else {
				draw_rpgtext(dialogueFace != undefined ? 178 : 60, 30 + dialogueAlignY, dialogueWriter.written, dialogueFont, 1, global.mainFontWidth, global.mainFontHeight, 1, 1, c_white);
			}
		}
		break;
}