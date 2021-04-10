function scr_save(){
	var buffer = buffer_create(1024, buffer_grow, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	
	buffer_write(buffer, buffer_string, global.name);
	buffer_write(buffer, buffer_u16, global.hp);
	buffer_write(buffer, buffer_u16, global.maxhp);
	buffer_write(buffer, buffer_u8, global.lv);
	buffer_write(buffer, buffer_u32, global.currentroom);
	buffer_write(buffer, buffer_u8, global.seconds);
	buffer_write(buffer, buffer_u32, global.minutes);
	
	var finalBuffer = buffer_compress(buffer, 0, buffer_tell(buffer));
	buffer_save(finalBuffer, get_savefile_name());
	
	buffer_delete(buffer);
	buffer_delete(finalBuffer);
}