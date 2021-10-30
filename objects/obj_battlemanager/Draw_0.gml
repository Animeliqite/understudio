/// @description Draw things needed

// Draw the background
draw_sprite(spr_battlebg, backgroundIndex, 0, 0);

// Draw the box
draw_box(boardX1, boardY1, boardX2, boardY2);

// Draw the player information
draw_set_color(c_white);
draw_sprite(spr_hpicon, 0, 220, 400);
draw_text_style(string_hash_to_newline(string(global.name) + "   LV " + string(global.lv)), 30, 400, fnt_mars, c_white, fa_left, fa_top);
draw_text_style(string_hash_to_newline(string(global.hp) + " / " +  string(global.maxhp)), 275 + (global.maxhp * 1.2), 400, fnt_mars, c_white, fa_left, fa_top);

draw_set_color(merge_colour(c_red, c_maroon, 0.5));
draw_rectangle(255, 400, 255 + (global.maxhp * 1.2), 420, false);

draw_set_color(c_yellow);
draw_rectangle(255, 400, 255 + (global.hp * 1.2), 420, false);

// Draw the buttons
draw_sprite_ext(spr_fightbt, (buttonIndex == 0 && menuno == 0 ? 1 : 0), 32, 432, 1, 1, 0, buttonColor[buttonIndex == 0 && menuno == 0 ? 2 : 0], 1);
draw_sprite_ext(spr_actbt, (buttonIndex == 1 && menuno == 0 ? 1 : 0), 185, 432, 1, 1, 0, buttonColor[buttonIndex == 1 && menuno == 0], 1);
draw_sprite_ext(spr_itembt, (buttonIndex == 2 && menuno == 0 ? 1 : 0), 345, 432, 1, 1, 0, buttonColor[buttonIndex == 2 && menuno == 0], 1);
draw_sprite_ext(spr_mercybt, (buttonIndex == 3 && menuno == 0 ? 1 : 0), 500, 432, 1, 1, 0, buttonColor[buttonIndex == 3 && menuno == 0], 1);

// Draw the heart (for buttons)
if (menuno == 0) {
	draw_sprite_ext(spr_battleheart, 0, 48 + (buttonIndex * 156), 453, 1, 1, 0, global.soulColor, 1);
	
	if (!instance_exists(obj_writer))
		create_writer(global.boardX1 + 20, global.boardY1 + 20, [battleMessages[0, (wroteIntroMessage ? random(array_length(battleMessages)) : 0)]], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false);
}
else if (menuno == 1) {
	var monsterInfoMessage = "`i` ";
	var drawWidth = 100;
	for (var i = 0; i < array_length(monsters); i++) {
		var add = global.boardX1 + 20 + string_width(monsterNames[i]);
		
		monsterInfoMessage += (monsterSpareable[i] ? "`cY` " : "`c$` ");
		monsterInfoMessage += (array_length(monsters) > i ? "   * " + monsterNames[i] + "&" : "");
		
		if (buttonIndex == 0) {
			draw_set_color(c_red);
			draw_rectangle(add + 120, 280 + (i * 35), add + 120 + drawWidth, 300 + (i * 35), false);
			draw_set_color(c_lime);
			draw_rectangle(add + 120, 280 + (i * 35), add + 120 + (monsterHP[i] / monsterHPMax[i]) * drawWidth, 300 + (i * 35), false);
		}
	}
	
	draw_sprite_ext(spr_battleheart, 0, global.boardX1 + 40, global.boardY1 + 35 + (monsterIndex * 35), 1, 1, 0, global.soulColor, 1);
	if (!instance_exists(obj_writer))
		create_writer(global.boardX1 + 20, global.boardY1 + 20, [monsterInfoMessage], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
}
else if (menuno == 2) {
	var currentMonster = battleMessages[1][bt_getcurrent_monster()];
	var actInfoMessage = ["`i` ", "`i` ", "`i` ", "`i` ", "`i` ", "`i` "];
	for (var i = 0; i < array_length(currentMonster); i++) {
		actInfoMessage[i] += "   * " + currentMonster[i];
		if (actWriters[i] == -1) {
			if (i < 2)
				actWriters[i] = create_writer(global.boardX1 + 20 + (i % 2 != 0 && i > 0 ? 260 : 0), global.boardY1 + 20, [actInfoMessage[i]], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
			else if (i < 4)
				actWriters[i] = create_writer(global.boardX1 + 20 + (i % 2 != 0 && i > 0 ? 260 : 0), global.boardY1 + 58, [actInfoMessage[i]], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
			else if (i < 6)
				actWriters[i] = create_writer(global.boardX1 + 20 + (i % 2 != 0 && i > 0 ? 260 : 0), global.boardY1 + 96, [actInfoMessage[i]], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
		}
	}
	draw_sprite_ext(spr_battleheart, 0, global.boardX1 + (actIndex % 2 != 0 && actIndex > 0 ? 300 : 40), global.boardY1 + 35 + floor(actIndex / 2) * 35, 1, 1, 0, global.soulColor, 1);
}
else if (menuno == 4) {
	var spareable = false;
	for (var i = 0; i < array_length(monsters); i++) {
		if (monsterSpareable[i])
			spareable = true;
	}
	
	if (!fleeing)
		draw_sprite_ext(spr_battleheart, 0, global.boardX1 + 40, global.boardY1 + 35 + (mercyIndex * 35), 1, 1, 0, global.soulColor, 1);
	if (!instance_exists(obj_writer))
		create_writer(global.boardX1 + 20, global.boardY1 + 20, ["`i`    " + (spareable ? "`cY` " : "") + "* Spare& `c$`   " + (battleFleeable ? "* Flee" : "")], battleMessageFormat, fnt_dialogue, c_white, 3, [snd_text_battle], 1, true, false, false);
}