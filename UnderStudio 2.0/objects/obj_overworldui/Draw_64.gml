/// @description Draw the user interface

// Initialize the variables
var cam = obj_camerahandler;

// Initialize the variables
var w = display_get_gui_width(), h = display_get_gui_height();
var cam = obj_camerahandler, onTop = false;

// Check if the dialogue box position checking is automated
if (dialogueIsOnTop == undefined && instance_exists(cam.currTarget))
	onTop = cam.posCenterY < cam.currTarget.y ? 310 : 0;
else onTop = dialogueIsOnTop ? true : false;

// Handle dialogue and transition states
if (state == 0) {
	draw_box(32, 10 + (onTop ? 0 : 310), 608, 160 + (onTop ? 0 : 310));
	
	if (dialogueFace != undefined)
		draw_sprite_ext(struct_get(dialogueFace, global.faceEmotion), dialogueFaceIndex, 100, onTop ? 75 : h - 95, 2, 2, 0, c_white, dialogueAlpha);
	
	// Check if the dialogue writer exists
	if (instance_exists(dialogueWriter)) {
		draw_text_extended(
		    dialogueFace != undefined ? 178 : 60,
		    30 + (onTop ? 0 : 310),
		    dialogueWriter.raw_text,     // The full text string, with all [commands] and `commands`
		    {
				halign: fa_left,
			    valign: fa_top,
			    size: 1,
			    visible: dialogueWriter.visible_chars,
			    font: dialogueFont,
			    alpha: 1,
			    color: c_white,
			    effect: "none",
				letter_width: global.mainFontWidth,
				letter_height: global.mainFontHeight,
			    letter_spacing: 0,
			    line_spacing: 1,
			    line_break: -1
			}
		);
	}
}