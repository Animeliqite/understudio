msg = "";
dogIndex = 0;
dogAngle = 0;
alarm[0] = room_speed / 2;
var f = file_text_open_read("crash.txt");
while (!file_text_eof(f)) {
	msg += file_text_read_string(f);
	file_text_readln(f);
}