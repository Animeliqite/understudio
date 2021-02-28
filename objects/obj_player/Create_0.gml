/// @description  Add the variables

// Starting variables
depth = depth_overworld.character;
image_index = 0;
image_speed = 0;

// Player sprite shortcut

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
inGenocide = global.geno_sprite;
moveSpeed = 3;

depth = -y;

sprite_index = spriteDown[inGenocide];

if (instance_exists(obj_marker_a)) && (global.spawn == 0) {
    x = obj_marker_a.x;
    y = obj_marker_a.y;
}

if (instance_exists(obj_marker_b)) && (global.spawn == 1) {
    x = obj_marker_b.x;
    y = obj_marker_b.y;
}

if (instance_exists(obj_marker_c)) && (global.spawn == 2) {
    x = obj_marker_c.x;
    y = obj_marker_c.y;
}

if (instance_exists(obj_marker_d)) && (global.spawn == 3) {
    x = obj_marker_d.x;
    y = obj_marker_d.y;
}

if (instance_exists(obj_marker_e)) && (global.spawn == 4) {
    x = obj_marker_e.x;
    y = obj_marker_e.y;
}

if (instance_exists(obj_marker_f)) && (global.spawn == 5) {
    x = obj_marker_f.x;
    y = obj_marker_f.y;
}

if (instance_exists(obj_marker_w)) && (global.spawn == 6) {
    x = obj_marker_w.x;
    y = obj_marker_w.y;
}

if (instance_exists(obj_marker_x)) && (global.spawn == 7) {
    x = obj_marker_x.x;
    y = obj_marker_x.y;
}

if (global.spawn == -1) {
    x = global.player_pos_x;
    y = global.player_pos_y;
}

