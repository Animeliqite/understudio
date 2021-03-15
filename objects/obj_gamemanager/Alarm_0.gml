/// @description Update the time

if (global.seconds < 59)
	global.seconds++;
else {
	global.minutes++;
	global.seconds = 0;
}
alarm[0] = room_speed;