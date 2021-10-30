/// @param messages
/// @param format
/// @param sprites
/// @args sound
/// @args speed

function bt_enemy_dialogue(){
	var messages = argument[0];
	var format = argument[1];
	var sprites = argument[2];
	var sound = [snd_text_default];
	var textSpeed = 2;
	
	if (argument_count > 3)
		sound = argument[3];
	
	if (argument_count > 4)
		textSpeed = argument[4];
	
	var bm = obj_battlemanager;
	var cm = bt_getcurrent_monster();
	var dialogue = [-1, -1, -1];
	
	for (var i = 0; i < array_length(bm.monsters); i++) {
		dialogue[i] = instance_create(bm.monsters[cm].x + (bm.monsters[cm].sprite_width / 2) + 30, bm.monsters[cm].y, obj_speechbubble);
		dialogue[i].text = messages;
		dialogue[i].sprite = sprites;
		dialogue[i].format = format;
		dialogue[i].sound = sound;
		dialogue[i].textSpeed = textSpeed;
	}
}