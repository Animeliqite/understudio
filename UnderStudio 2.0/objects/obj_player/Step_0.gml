/// @description Functionality

// Initialize the variables
var u = BT_UP, d = BT_DOWN, l = BT_LEFT, r = BT_RIGHT;
var sprWidth = sprite_width, sprHeight = sprite_height;

// Make it so that two buttons are not pressed at the same time
if (l && r) r = false;
if (u && d) d = false;

// Check what buttons are pressed
if (canMove && canMoveOverworldMenu && canMoveDialogue) {
	move_and_collide(hspd,vspd,obj_solidparent);
	
	if (u) {
		vspd = -moveSpeed;
		if (!l && !r) || (currDir == DIR_DOWN)
			currDir = DIR_UP;
	}

	if (d) {
		vspd = moveSpeed;
		if (!l && !r) || (currDir == DIR_UP)
			currDir = DIR_DOWN;
	}

	if (l) {
		hspd = -moveSpeed;
		if (!u && !d) || (currDir == DIR_RIGHT)
			currDir = DIR_LEFT;
	}

	if (r) {
		hspd = moveSpeed;
		if (!u && !d) || (currDir == DIR_LEFT)
			currDir = DIR_RIGHT;
	}
	
	if (!u && !d) vspd = 0;
	if (!l && !r) hspd = 0;
	
	// Slope collision check!
	if (place_meeting(x, y, obj_slopeparent)) {
		var inst = instance_place(x, y, obj_slopeparent);
		if (place_meeting(x, y, obj_slope_bl)) {
			if (d) x += moveSpeed * (inst.image_xscale / inst.image_yscale);
			if (l) y -= moveSpeed * (inst.image_yscale / inst.image_xscale);
		}
		
		if (place_meeting(x, y, obj_slope_br)) {
			if (d) x -= moveSpeed * (inst.image_xscale / inst.image_yscale);
			if (r) y -= moveSpeed * (inst.image_yscale / inst.image_xscale);
		}
		
		if (place_meeting(x, y, obj_slope_tl)) {
			if (u) x += moveSpeed * (inst.image_xscale / inst.image_yscale);
			if (l) y += moveSpeed * (inst.image_yscale / inst.image_xscale);
		}
		
		if (place_meeting(x, y, obj_slope_tr)) {
			if (u) x -= moveSpeed * (inst.image_xscale / inst.image_yscale);
			if (r) y += moveSpeed * (inst.image_yscale / inst.image_xscale);
		}
	}
	
	// Overworld Menu
	if (BT_CONTROL_P) {
		// Activate the overworld menu user interface
		obj_overworldmenu.active = true;
		
		// Set the overworld menu can move variable to false
		canMoveOverworldMenu = false;
	}
	
	// INTERACTION
	
	// Check if there's a collision with an NPC
	if (collision_rectangle(x - (sprWidth / 2) - 5, y - (sprHeight / 2) - 5, x + (sprWidth / 2) + 5, y + (sprWidth / 2) + 5, obj_npcparent, false, false)) {
		var dirAsResponse = undefined;
		
		// Check if the player has a collision with an NPC
		if (place_meeting(x, y, obj_npcparent)) {
			// Relocate the X position of the player
			x = xprevious;
			
			// Relocate the Y position of the player
			y = yprevious;
		}
		
		// Check if the player is facing up
		if (currDir == DIR_UP) {
			if (collision_line(x, y, x, y - sprHeight + 5, obj_npcparent, false, false))
				dirAsResponse = DIR_DOWN; // The NPC is going to look down
		}
		
		// Check if the player is facing down
		if (currDir == DIR_DOWN) {
			if (collision_line(x, y, x, y + sprHeight - 5, obj_npcparent, false, false))
				dirAsResponse = DIR_UP; // The NPC is going to look up
		}
		
		// Check if the player is facing left
		if (currDir == DIR_LEFT) {
			if (collision_line(x, y, x - sprHeight + 5, y, obj_npcparent, false, false))
				dirAsResponse = DIR_RIGHT; // The NPC is going to look right
		}
		
		// Check if the player is facing right
		if (currDir == DIR_RIGHT) {
			if (collision_line(x, y, x + sprHeight - 5, y, obj_npcparent, false, false))
				dirAsResponse = DIR_LEFT; // The NPC is going to look left
		}
		
		// Check if the confirm key is pressed
		if (BT_ENTER_P) {
			// Check if the response direction is not undefined
			if (!is_undefined(dirAsResponse))
				// Execute a code as the NPC parent object
				with (instance_nearest(x, y, obj_npcparent)) {
					// Check if the overworld menu is active
					if (!obj_overworldmenu.active) {
						// Set the NPC's direction to the response direction
						currDir = dirAsResponse;
						
						// Execute the user event
						event_user(0);
					}
				}
		}
	}
	
	// Check if the player's moving
	if (x != xprevious || y != yprevious) {
		// Increase the current steps taken
		stepsTaken++;
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
		
		moving = true;
	}
	else {
		image_index = 0;
		image_speed = 0;
		
		moving = false;
	}
}