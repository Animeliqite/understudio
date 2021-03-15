event_inherited();

if (!instance_exists(obj_dialogue) && (interact_amount == 1) && (!show_ui)) {
	global.cutscene = true;
	show_ui = true;
	selection = 0;
}