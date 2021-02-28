function scr_save(){
	ini_open_encrypted_zlib("save_" + string(global.currentsave) + ".ini", "YouDirtyHacker")
	
	ini_write_real("Player", "Name", global.name);
	ini_write_real("Player", "HP", global.hp);
	ini_write_real("Player", "MaxHP", global.maxhp);
	ini_write_real("Player", "LV", global.lv);
	ini_write_real("Player", "Room", global.currentroom);
	
	for (var i = 0; i < 256; i++;) {
		ini_write_real("Flag", "FlagNo_" + string(i), global.flag[i]);
	}
	
	ini_close_encrypted_zlib("save_" + string(global.currentsave) + ".ini", "YouDirtyHacker");
}