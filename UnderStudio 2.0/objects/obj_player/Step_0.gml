/// @description Functionality

// Initialize the variables
var u = BT_UP, d = BT_DOWN, l = BT_LEFT, r = BT_RIGHT;
var sprWidth = sprite_width, sprHeight = sprite_height;

// Make it so that two buttons are not pressed at the same time
if (l && r) r = false;
if (u && d) d = false;

// Check what buttons are pressed
if (canMove && canMoveOverworldMenu && canMoveDialogue) {
	var tries = 0;
	while (place_meeting(x, y - moveSpeed, obj_solidparent) && !d) y += 0.01;
	while (place_meeting(x, y + moveSpeed, obj_solidparent) && !u) y -= 0.01;
	while (place_meeting(x - moveSpeed, y, obj_solidparent) && !r) x += 0.01;
	while (place_meeting(x + moveSpeed, y, obj_solidparent) && !l) x -= 0.01;
	
	repeat (moveSpeed * 10) {
		if (u) {
			y -= 0.1;
			if (!l && !r) || (currDir == DIR_DOWN)
				currDir = DIR_UP;
		}

		if (d) {
			y += 0.1;
			if (!l && !r) || (currDir == DIR_UP)
				currDir = DIR_DOWN;
		}

		if (l) {
			x -= 0.1;
			if (!u && !d) || (currDir == DIR_RIGHT)
				currDir = DIR_LEFT;
		}

		if (r) {
			x += 0.1;
			if (!u && !d) || (currDir == DIR_LEFT)
				currDir = DIR_RIGHT;
		}
	}
	
	// Slope collision check!
	if (place_meeting(x, y, obj_slopeparent)) {
		if (place_meeting(x, y, obj_slope_bl)) {
			if (d) x += moveSpeed;
			if (l) y -= moveSpeed;
		}
		
		if (place_meeting(x, y, obj_slope_br)) {
			if (d) x -= moveSpeed;
			if (r) y -= moveSpeed;
		}
		
		if (place_meeting(x, y, obj_slope_tl)) {
			if (u) x += moveSpeed;
			if (l) y += moveSpeed;
		}
		
		if (place_meeting(x, y, obj_slope_tr)) {
			if (u) x -= moveSpeed;
			if (r) y += moveSpeed;
		}
	}
	
	// Overworld Menu
	if (BT_CONTROL_P) {
		obj_overworldmenu.active = true;
		canMoveOverworldMenu = false;
	}
	
	// Interaction
	if (collision_rectangle(x - (sprWidth / 2) - 5, y - (sprHeight / 2) - 5, x + (sprWidth / 2) + 5, y + (sprWidth / 2) + 5, obj_npcparent, false, false)) {
		var dirAsResponse = undefined;
		
		// Relocate the player
		if (place_meeting(x, y, obj_npcparent)) {
			x = xprevious;
			y = yprevious;
		}
		
		// Check for where the player is facing to
		if (currDir == DIR_UP) {
			if (collision_line(x, y, x, y - sprHeight + 5, obj_npcparent, false, false))
				dirAsResponse = DIR_DOWN;
		}
		if (currDir == DIR_DOWN) {
			if (collision_line(x, y, x, y + sprHeight - 5, obj_npcparent, false, false))
				dirAsResponse = DIR_UP;
		}
		if (currDir == DIR_LEFT) {
			if (collision_line(x, y, x - sprHeight + 5, y, obj_npcparent, false, false))
				dirAsResponse = DIR_RIGHT;
		}
		if (currDir == DIR_RIGHT) {
			if (collision_line(x, y, x + sprHeight - 5, y, obj_npcparent, false, false))
				dirAsResponse = DIR_LEFT;
		}
		
		// Interaction
		if (BT_ENTER_P) {
			if (!is_undefined(dirAsResponse))
				with (instance_nearest(x, y, obj_npcparent)) {
					if (!obj_overworldmenu.active) {
						currDir = dirAsResponse;
						event_user(0);
					}
				}
		}
	}
	// Check if the player's moving
	if (x != xprevious || y != yprevious) {
		stepsTaken++; // Increase the current steps taken
	}
}
else {
	if (!obj_overworldmenu.active) canMoveOverworldMenu = true;
}

// Animating the object
if (animateObject) {
	if (x != xprevious || y != yprevious) {
		if (image_speed == 0) image_index = 1;
		image_speed = moveSpeed / 15;
	
		xprevious = x;
		yprevious = y;
	}
	else {
		image_index = 0;
		image_speed = 0;
	}
}