/// @param messages
/// @args font
/// @args baseColor
/// @args textEffect
/// @args textSound

function create_dialogue(){
	var messages = argument0;
	var font = fnt_dialogue;
	var baseColor = c_white;
	var textEffect = 0;
	var textSound = [snd_text_default];
	
	if (!is_undefined(argument1)) {
		var font = argument1;
	}
	if (!is_undefined(argument2)) {
		var baseColor = argument2;
	}
	if (!is_undefined(argument3)) {
		var textEffect = argument3;
	}
	if (!is_undefined(argument4)) {
		var textSound = argument4;
	}
	
    global.cutscene = true;
        
    var d = instance_create(0, 0, obj_dialogue);
            
	for (var i = 0; i < array_length_1d(messages); i++;) {
        d.messages[i] = messages[i];
    }
                
    d.font = font;
    d.baseColor = baseColor;
    d.textEffect = textEffect;
	d.textSound = textSound;
}