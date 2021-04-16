function stats_init(){
	global.fun = random_range(0, 99);
	global.murderlv = 0;
	
	global.name = "CHARA";
	global.lv = 1;
	global.hp = 20;
	global.maxhp = 20;
	global.xp = 0;
	global.gold = 0;

	global.weapon = ds_list_create();
	global.armor = ds_list_create();
	
	global.currentwep = 0;
	global.currentarm = 0;
	
	global.inv_item = ds_list_create();
	
	global.currentroom = room;
	global.currentsong = undefined;
	
	global.flag = ds_map_create();
}