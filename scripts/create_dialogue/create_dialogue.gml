/// @param messages
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
	
    global.cutscene = true;
        
    var d = instance_create(0, 0, obj_dialogue);
            
	for (var i = 0; i < array_length(messages); i++;) {
        d.messages[i] = messages[i];
    }
	
	for (var i = 0; i < array_length(formatList); i++;) {
        global.format[i] = formatList[i];
    }
                
    d.font = font;
    d.baseColor = baseColor;
    d.textEffect = textEffect;
	d.textSound = textSound;
}