/// @description Functionality

// Initialize the variables
var u = BT_UP, d = BT_DOWN, l = BT_LEFT, r = BT_RIGHT;
var collisionLeft = place_meeting(x - moveSpeed, y, obj_solidparent);
var collisionRight = place_meeting(x + moveSpeed, y, obj_solidparent);
var collisionUp = place_meeting(x, y - moveSpeed, obj_solidparent);
var collisionDown = place_meeting(x, y + moveSpeed, obj_solidparent);
var sprWidth = sprite_width, sprHeight = sprite_height;

// Make it so that two buttons are not pressed at the same time
if (l && r) r = false;
if (u && d) d = false;

// Check what buttons are pressed
if (canMove && !global.inCutscene) {
	if (u) {
		if (!collisionUp)
			y -= moveSpeed;
		if (!l && !r) || (currDir == DIR_DOWN)
			currDir = DIR_UP;
	}

	if (d) {
		if (!collisionDown)
			y += moveSpeed;
		if (!l && !r) || (currDir == DIR_UP)
			currDir = DIR_DOWN;
	}

	if (l) {
		if (!collisionLeft)
			x -= moveSpeed;
		if (!u && !d) || (currDir == DIR_RIGHT)
			currDir = DIR_LEFT;
	}

	if (r) {
		if (!collisionRight)
			x += moveSpeed;
		if (!u && !d) || (currDir == DIR_LEFT)
			currDir = DIR_RIGHT;
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
					currDir = dirAsResponse;
					event_user(0);
				}
		}
	}
	// Check if the player's moving
	if (x != xprevious || y != yprevious) {
		stepsTaken++; // Increase the current steps taken
	}
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