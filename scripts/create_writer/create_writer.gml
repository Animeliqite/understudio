/// @param x
/// @param y
/// @param messages
/// @args format
/// @args font
/// @args baseColor
/// @args textEffect
/// @args textSound
/// @args textSpeed
/// @args skippable
/// @args confirmable

function create_writer(){
	var xx = argument0;
	var yy = argument1;
	var messages = argument2;
	var formatList = [];
	var font = fnt_dialogue;
	var baseColor = c_white;
	var textEffect = 0;
	var textSound = [snd_text_default];
	var textSpeed = 1;
	var skippable = true;
	var confirmable = true;
	
	if (!is_undefined(argument3)) {
		var formatList = argument3;
	}
	if (!is_undefined(argument4)) {
		var font = argument4;
	}
	if (!is_undefined(argument5)) {
		var baseColor = argument5;
	}
	if (!is_undefined(argument6)) {
		var textEffect = argument6;
	}
	if (!is_undefined(argument7)) {
		var textSound = argument7;
	}
	if (!is_undefined(argument8)) {
		var textSpeed = argument8;
	}
	if (!is_undefined(argument9)) {
		var skippable = argument9;
	}
	if (!is_undefined(argument10)) {
		var confirmable = argument10;
	}
	
    var w = instance_create(xx, yy, obj_writer);
            
	for (var i = 0; i < array_length(messages); i++;) {
        w.messages[i] = messages[i];
    }
	
	for (var i = 0; i < array_length(formatList); i++;) {
        global.format[i] = formatList[i];
    }
	
    w.font = font;
    w.baseColor = baseColor;
    w.textEffect = textEffect;
	w.textSound = textSound;
	w.textSpeed = textSpeed;
	w.skippable = skippable;
	w.confirmable = confirmable;
}