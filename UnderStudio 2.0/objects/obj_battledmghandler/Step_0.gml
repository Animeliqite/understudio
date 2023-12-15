/// @description Functionality

if (!jumped) {
	if (dmgY <= 0) {
		jumpAmount += 12 / room_speed;
		dmgY += jumpAmount;
	}
	else {
		alarm[0] = 1;
		jumped = true;
	}
}