menuno = (file_exists(get_savefile_name()) ? 3 : 0);
cooldown = 2;
global.name = (file_exists(get_savefile_name()) ? global.name : "");

hasName = false;
tempName = global.name;

sel[0] = 0;
sel[1] = 0;
sel[2] = 0;
sel[3] = 0;

nameTween = -1;

nameScale = 1;
nameX = 0;
nameY = 0;

nameResponse = "";
nameChooseable = true;

fadingToWhite = false;

if (file_exists(get_savefile_name())) {
	var buffer = buffer_load(get_savefile_name());
	var finalBuffer = buffer_decompress(buffer);

	name = buffer_read(finalBuffer, buffer_string);
	hp = buffer_read(finalBuffer, buffer_u16);
	maxhp = buffer_read(finalBuffer, buffer_u16);
	lv = buffer_read(finalBuffer, buffer_u8);
	currentroom = buffer_read(finalBuffer, buffer_u32);
	seconds = buffer_read(finalBuffer, buffer_u8);
	minutes = buffer_read(finalBuffer, buffer_u32);

	buffer_delete(buffer);
	buffer_delete(finalBuffer);
}

mus_loop_safe(0, "menu", 1, 1);