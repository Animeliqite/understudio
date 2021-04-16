/// @description  Add the variables

// Starting variables
depth = depth_overworld.character;
image_index = 0;
image_speed = 0;

// Overworld sprites
spriteDown = spr_player_down;
spriteUp = spr_player_up;
spriteLeft = spr_player_left;
spriteRight = spr_player_right;

// Main player variables
facingTo = "down";
inGenocide = (global.murderlv > 0);
moveSpeed = 3;
dance = false;

depth = depth_overworld.character-y;
sprite_index = spriteDown;

if (global.spawn == -1) {
	x = global.playerX;
	y = global.playerY;
}