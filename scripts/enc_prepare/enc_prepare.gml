/// @param encounters
/// @args [bubble
/// @args animation
/// @args progressQuick]
function enc_prepare() {
	var encounters = argument[0];
	var showBubble = true, animateSoul = true, progressQuick = false;
	
	if (!is_undefined(argument[1]))
		showBubble = argument[1];
	
	if (!is_undefined(argument[2]))
		animateSoul = argument[2];
	
	if (!is_undefined(argument[3]))
		progressQuick = argument[3];
	
	var object = instance_create_depth(0, 0, 0, obj_encountersetup);
	object.encounters = encounters;
	object.showBubble = showBubble;
	object.animateSoul = animateSoul;
	object.progressQuick = progressQuick;
}