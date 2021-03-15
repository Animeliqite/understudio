function scr_load(){
	ini_open_encrypted_zlib(game_savename + ".ini", global.key);
	
	global.name = ini_read_string("Player", "Name", "Chara");
	global.hp = ini_read_real("Player", "HP", 20);
	global.maxhp = ini_read_real("Player", "MaxHP", 20);
	global.lv = ini_read_real("Player", "LV", 1);
	global.currentroom = ini_read_real("Player", "Room", room_empty);
	global.seconds = ini_read_real("Time", "Seconds", 0);
	global.minutes = ini_read_real("Time", "Minutes", 0);
		
	for (var i = 0; i < 256; i++;) {
		global.flag[i] = ini_read_real("Flag", "FlagNo_" + string(i), false);
	}
	
	ini_close();
}