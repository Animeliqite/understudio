/// @param messages
/// @args format
/// @args font
/// @args baseColor
/// @args textEffect
/// @args textSound

function create_dialogue(){
	var messages = argument0;
	var formatList = [];
	var font = fnt_dialogue;
	var baseColor = c_white;
	var textEffect = 0;
	var textSound = [snd_text_default];
	
	if (!is_undefined(argument1)) {
		var formatList = argument1;
	}
	if (!is_undefined(argument2)) {
		var font = argument2;
	}
	if (!is_undefined(argument3)) {
		var baseColor = argument3;
	}
	if (!is_undefined(argument4)) {
		var textEffect = argument4;
	}
	if (!is_undefined(argument5)) {
		var textSound = argument5;
	}
	
	var d = instance_create(0, 0, obj_dialogue);
	global.format = formatList;
	d.messages = messages;
    d.font = font;
    d.baseColor = baseColor;
    d.textEffect = textEffect;
	d.textSound = textSound;
	
    global.cutscene = true;
}