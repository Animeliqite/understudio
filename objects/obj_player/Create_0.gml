/// @description  Add the variables

// Starting variables
depth = depth_overworld.character;
image_index = 0;
image_speed = 0;

// Overworld sprites
spriteDown[0] = spr_player_down;
spriteUp[0] = spr_player_up;
spriteLeft[0] = spr_player_left;
spriteRight[0] = spr_player_right;

// Genocide sprites
spriteDown[1] = spr_player_down;
spriteUp[1] = spr_player_up;
spriteLeft[1] = spr_player_left;
spriteRight[1] = spr_player_right;

// Main player variables
facingTo = "DOWN";
inGenocide = (global.murderlv > 0 ? true : false);
moveSpeed = 3;
dance = false;

depth = depth_overworld.character-y;
sprite_index = spriteDown[inGenocide];

if (global.spawn == -1) {
    x = global.player_pos_x;
    y = global.player_pos_y;
}