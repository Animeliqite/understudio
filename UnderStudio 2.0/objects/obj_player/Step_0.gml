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
	
	// Directional interaction area in front of the player
	var interact_x1, interact_y1, interact_x2, interact_y2;
			
	var offset = 6; // how far in front of player to check
	var range = 12; // width/height of the interaction box
	var dir_response; // NPC direction response
			
	switch (currDir) {
		case DIR_UP:
			interact_x1 = x - range / 2;
			interact_y1 = y - offset - range;
			interact_x2 = x + range / 2;
			interact_y2 = y - offset;
			dir_response = DIR_DOWN;
			break;
		case DIR_DOWN:
			interact_x1 = x - range / 2;
			interact_y1 = y + offset;
			interact_x2 = x + range / 2;
			interact_y2 = y + offset + range + 6;
			dir_response = DIR_UP;
			break;
		case DIR_LEFT:
			interact_x1 = x - offset - range;
			interact_y1 = y - range / 2;
			interact_x2 = x - offset;
			interact_y2 = y + range / 2;
			dir_response = DIR_RIGHT;
			break;
		case DIR_RIGHT:
			interact_x1 = x + offset;
			interact_y1 = y - range / 2;
			interact_x2 = x + offset + range;
			interact_y2 = y + range / 2;
			dir_response = DIR_LEFT;
			break;
	}
			
	// Check for NPCs directly in front
	var interaction = collision_rectangle(interact_x1, interact_y1, interact_x2, interact_y2, obj_npcparent, false, true);

	if (interaction != noone && !dx_is_active()) {
		if (BT_ENTER_P && canInteract && global.interactionCooldown <= 0) {
			if (!obj_overworldmenu.active) {
			    with (interaction) {
			        currDir = dir_response; // NPC looks toward player
			        event_user(0); // trigger dialogue or response
			    }
			}
		}

		if (canInteract && global.interactionCooldown > 0) {
			global.interactionCooldown--;
		}
	}
			
	// Special collision for NPCs
	if (place_meeting(x, y, obj_npc_scene)) {
		var inst = instance_place(x, y, obj_npc_scene);
		if (inst.collision && !inst.smoothCollision) {
			x = xprevious;
			y = yprevious;
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