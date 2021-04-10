if (menuno == 0) {
	draw_text_style(get_message("instructionHeader"), 200, 40, fnt_dialogue, c_silver, fa_left, fa_top);
	draw_text_style("[Z or ENTER] - " + get_message("instructionConfirm"), 200, 100, fnt_dialogue, c_silver, fa_left, fa_top);
	draw_text_style("[X or SHIFT] - " + get_message("instructionCancel"), 200, 136, fnt_dialogue, c_silver, fa_left, fa_top);
	draw_text_style("[C or CTRL] - " + get_message("instructionMenu"), 200, 172, fnt_dialogue, c_silver, fa_left, fa_top);
	draw_text_style("[F4] - " + get_message("instructionFullscreen"), 200, 208, fnt_dialogue, c_silver, fa_left, fa_top);
	draw_text_style("[Hold ESC] - " + get_message("instructionExit"), 200, 244, fnt_dialogue, c_silver, fa_left, fa_top);
	draw_text_style(get_message("instructionOnLose"), 200, 280, fnt_dialogue, c_silver, fa_left, fa_top);
	
	draw_text_style(get_message("instructionGameBegin"), 200, 344, fnt_dialogue, (sel[0] == 0 ? c_yellow : c_white), fa_left, fa_top);
	draw_text_style(get_message("instructionSettings"), 200, 384, fnt_dialogue, (sel[0] == 1 ? c_yellow : c_white), fa_left, fa_top);
	
	draw_text_style(game_name + " v" + game_version + " (C) " + game_owner + " 2021-2021", 320, 474, fnt_crypt, c_gray, fa_center, fa_bottom);
}
if (menuno == 1) {
	randomize();
	var m = 0;
	var o = 0;
	
	draw_text_style(get_message("nameSelectionHeader"), 320, 93, fnt_dialogue, c_white, fa_center, fa_bottom);
	draw_text_style(global.name, 280, 111, fnt_dialogue, c_white, fa_left, fa_top);
	for (var n = 0; n < 26; n++) {
		if (n == 7) || (n == 14) || (n == 21) {
			m += 28;
			o = n * 63;
		}
		draw_text_style(chr(65 + n), 120 + (n * 63) - o + irandom(1), 150 + m + irandom(1), fnt_dialogue, (sel[1] == n ? c_yellow : c_white), fa_left, fa_top);
		draw_text_style(chr(97 + n), 120 + (n * 63) - o + irandom(1), 270 + m + irandom(1), fnt_dialogue, (sel[1] == n + 26 ? c_yellow : c_white), fa_left, fa_top);
	}
	
	draw_text_style(get_message("nameSelectionQuit"), 120, 401, fnt_dialogue, (sel[1] == 53 ? c_yellow : c_white), fa_left, fa_top);
	draw_text_style(get_message("nameSelectionBackspace"), 240, 401, fnt_dialogue, (sel[1] == 54 ? c_yellow : c_white), fa_left, fa_top);
	draw_text_style(get_message("nameSelectionDone"), 440, 401, fnt_dialogue, (sel[1] == 55 ? c_yellow : c_white), fa_left, fa_top);
}
if (menuno == 2) || (menuno == 999) {
	if (!fadingToWhite) {
		draw_text_style((nameResponse != "" ? nameResponse : get_message("nameResultDefault")), 180, 61, fnt_dialogue, c_white, fa_left, fa_top);
		draw_text_style((nameChooseable ? get_message("nameResultNo") : get_message("nameResultGoBack")), 160, 400, fnt_dialogue, (sel[2] == 0 ? c_yellow : c_white), fa_center, fa_top);
		draw_text_style((nameChooseable ? get_message("nameResultYes") : ""), 460, 400, fnt_dialogue, (sel[2] == 1 ? c_yellow : c_white), fa_left, fa_top);
	}
	draw_text_style_scaled(global.name, 280 + nameX, 111 + nameY, fnt_dialogue, c_white, fa_left, fa_top, nameScale, nameScale, -random(2));
}
if (menuno == 3) {
	lv_pos = round(320 + (string_width(name) / 2) - (string_width(string(minutes) + ":" + string(seconds)) / 2) - (string_width(get_message("saveInfo_LV") + " " + string(lv)) / 2));
	draw_text_style(room_getname(currentroom), 140, 160, fnt_dialogue, c_white, fa_left, fa_top);
	draw_text_style(name, 140, 124, fnt_dialogue, c_white, fa_left, fa_top);
	draw_text_style(get_message("saveInfo_LV") + " " + string(lv), lv_pos, 124, fnt_dialogue, c_white, fa_left, fa_top);
	draw_text_style(string(minutes) + ":" + (seconds < 10 ? "0" : "") + string(seconds), 500, 124, fnt_dialogue, c_white, fa_right, fa_top);
	
	draw_text_style(get_message("menuContinue"), 170, 210, fnt_dialogue, (sel[3] == 0 ? c_yellow : c_white), fa_left, fa_top);
	draw_text_style(get_message("menuReset"), 390, 210, fnt_dialogue, (sel[3] == 1 ? c_yellow : c_white), fa_left, fa_top);
	draw_text_style(get_message("menuSettings"), 264, 250, fnt_dialogue, (sel[3] == 2 ? c_yellow : c_white), fa_left, fa_top);
	
	draw_text_style(game_name + " v" + game_version + " (C) " + game_owner + " 2021-2021", 320, 474, fnt_crypt, c_gray, fa_center, fa_bottom);
}