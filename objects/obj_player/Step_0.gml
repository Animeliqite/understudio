/// @description Move the player

var dancing = false;
var u = global.up_hold, d = global.down_hold, l = global.left_hold, r = global.right_hold;
var collLeft = place_meeting(x - moveSpeed, y, obj_solid_parent),
	collRight = place_meeting(x + moveSpeed, y, obj_solid_parent),
	collUp = place_meeting(x, y - moveSpeed, obj_solid_parent),
	collDown = place_meeting(x, y + moveSpeed, obj_solid_parent);

if (!global.cutscene) {
	if (l && r)
		r = false;
	
	// Left
	if (l && !collLeft) {
		x -= moveSpeed;
		if (!(u && d) && !(u && facingTo == "up") && !(d && facingTo == "down"))
			facingTo = "left";
    }
	
	// Right
    if (r && !collRight) {
		x += moveSpeed;
		if (!(u && d) && !(u && facingTo == "up") && !(d && facingTo == "down"))
			facingTo = "right";
    }
	
	// Up
    if (u && !collUp) {
		if (!dancing) {
			y -= moveSpeed;
			d = false;
		}
		if (dancing || (!(l && facingTo == "left") && !(r && facingTo == "right")))
			facingTo = "up";
    }
	
	// Down
    if (d && !collDown) {
		y += moveSpeed;
		if (!(l && facingTo == "left") && !(r && facingTo == "right"))
			facingTo = "down";
    }
	
	dancing = (u && d && collUp);
	
	if (place_meeting(x, y, obj_door)) {
		instance_nearest(x, y, obj_door).fade = true;
		global.cutscene = true;
	}
	
	if (collision_rectangle(x - 2, y - 2, x + sprite_width + 2, y + sprite_height + 2, instance_nearest(x, y, obj_interactable), false, false)) {
	    with (instance_nearest(x, y, obj_interactable)) {
			if (global.confirm) && (!global.cutscene) && (interactable) {
				create_dialogue(messages, formatList, font, baseColor, textEffect, textSound);
				interact_amount++;
				alarm[0] = 1; //On Dialogue Start
			}
	    }
	}
	
	if (place_meeting(x, y, obj_npc_parent)) {
		x = xprevious;
		y = yprevious;
	}
	
	// C-Menu
	if (global.menu) {
	    keyboard_clear(vk_lcontrol);
	    keyboard_clear(ord("C"));
    
	    if (!instance_exists(obj_cmenu)) {
	        instance_create(0, 0, obj_cmenu);
	    }
	}
	
	for(var i = 0; i < 2; i++) {
		var collisionDir = ["l", "r"];
		if(place_meeting(x + moveSpeed * (collisionDir[i] == "l" ? 1 : -1), y + moveSpeed, asset_get_index("obj_slope_u" + collisionDir[i]))){
			if ((collisionDir[i]=="l" ? global.left_hold : global.right_hold)) {
				y += moveSpeed;
			}
			if (global.up_hold) {
				x += moveSpeed * (collisionDir[i] == "l" ? 1 : -1);
			}
		}
		if(place_meeting(x + moveSpeed * (collisionDir[i] == "l" ? 1 : -1), y - moveSpeed, asset_get_index("obj_slope_d" + collisionDir[i]))){
			if ((collisionDir[i]=="l" ? global.left_hold : global.right_hold)) {
				y -= moveSpeed;
			}
			if (global.down_hold) {
				x += moveSpeed * (collisionDir[i] == "l" ? 1 : -1);
			}
		}
	}
}

switch (facingTo) {
	case "up":
		sprite_index = spriteUp;
		break;
	case "down":
		sprite_index = spriteDown;
		break;
	case "left":
		sprite_index = spriteLeft;
		break;
	case "right":
		sprite_index = spriteRight;
		break;
}

if (x == xprevious) && (y == yprevious) {
	image_speed = 0;
	image_index = 0;
}
else {
	if (image_speed == 0)
		image_index = 1;
	image_speed = moveSpeed / 15;
	
	if (!global.cutscene) {
		if (instance_exists(obj_encountersetup))
			obj_encountersetup.currentSteps++;
	}
}

depth = depth_overworld.character-y + (sprite_height / 2);

// Debug System
if (global.debug == true) {
    if (keyboard_check_pressed(ord("V"))) {
        if (instance_exists(obj_solid_parent)) {
            with (obj_solid_parent) {
                visible = !visible;
            }
        }
        if (instance_exists(obj_door)) {
            with (obj_door) {
                visible = !visible;
            }
        }
        if (instance_exists(obj_entrance)) {
            with (obj_entrance) {
                visible = !visible;
            }
        }
        if (instance_exists(obj_slope_dl)) {
            with (obj_slope_dl) {
                visible = !visible;
            }
        }
        if (instance_exists(obj_slope_dr)) {
            with (obj_slope_dr) {
                visible = !visible;
            }
        }
        if (instance_exists(obj_slope_ul)) {
            with (obj_slope_ul) {
                visible = !visible;
            }
        }
        if (instance_exists(obj_slope_ur)) {
            with (obj_slope_ur) {
                visible = !visible;
            }
        }
    }
}