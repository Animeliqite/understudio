function scr_load(){
	var buffer = buffer_load(get_savefile_name());
	var finalBuffer = buffer_decompress(buffer);
	
	global.name = buffer_read(finalBuffer, buffer_string);
	global.hp = buffer_read(finalBuffer, buffer_u16);
	global.maxhp = buffer_read(finalBuffer, buffer_u16);
	global.lv = buffer_read(finalBuffer, buffer_u8);
	global.currentroom = buffer_read(finalBuffer, buffer_u32);
	global.seconds = buffer_read(finalBuffer, buffer_u8);
	global.minutes = buffer_read(finalBuffer, buffer_u32);
	
	buffer_delete(buffer);
	buffer_delete(finalBuffer);
}