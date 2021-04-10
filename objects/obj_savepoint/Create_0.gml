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

if (file_exists(get_savefile_name())) {
	var buffer = buffer_load(get_savefile_name());
	var finalBuffer = buffer_decompress(buffer);
	
	name = buffer_read(finalBuffer, buffer_string);
	hp = buffer_read(finalBuffer, buffer_u16);
	maxhp = buffer_read(finalBuffer, buffer_u16);
	love = buffer_read(finalBuffer, buffer_u8);
	roomname = buffer_read(finalBuffer, buffer_u32);
	seconds = buffer_read(finalBuffer, buffer_u8);
	minutes = buffer_read(finalBuffer, buffer_u32);
	
	buffer_delete(buffer);
	buffer_delete(finalBuffer);
}
else {
	roomname = -1;
	name = "EMPTY";
	love = 0;
	seconds = 0;
	minutes = 0;
}

lv_pos = round(320 + (string_width(name) / 2) - (string_width(string(minutes) + ":" + string(seconds)) / 2) - (string_width(get_message("saveInfo_LV") + " " + string(love)) / 2));