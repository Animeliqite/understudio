function stats_init(){
	global.fun = random_range(0, 99);
	global.name = "CHARA";
	global.lv = 1;
	global.hp = 20;
	global.maxhp = 20;
	global.xp = 0;
	global.gold = 0;

	global.weapon = -1;
	global.armor = -1;
	
	global.currentwep = 0;
	global.currentarm = 0;
	
	global.inv_item = ds_list_create();
	
	global.currentroom = room;
	global.currentsong = undefined;
	
	for (var i = 0; i < 256; i++;) {
		global.flag[i] = false;
	}
}