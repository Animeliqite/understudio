event_inherited();
image_speed = 1;

messages = ["* Determination."];
baseColor = c_white;
font = fnt_dialogue;
textEffect = 0; // 0 = none, 1 = shaking, 2 = wavy
textSpeed = 1;
textSound = [snd_text_default];

selection = 0;
state = 0;
show_ui = false;

if (file_exists(game_savename + ".ini")) {
	ini_open_encrypted_zlib(game_savename + ".ini", global.key);
	roomname = ini_read_real("Player", "Room", -1);
	name = ini_read_string("Player", "Name", "EMPTY");
	love = ini_read_real("Player", "LV", 0);
	seconds = ini_read_real("Time", "Seconds", 1);
	minutes = ini_read_real("Time", "Minutes", 1);
	ini_close();
}
else {
	roomname = -1;
	name = "EMPTY";
	love = 0;
	seconds = 0;
	minutes = 0;
}

lv_pos = round(320 + (string_width(name) / 2) - (string_width(string(minutes) + ":" + string(seconds)) / 2) - (string_width(get_message("saveInfo_LV") + " " + string(love)) / 2));