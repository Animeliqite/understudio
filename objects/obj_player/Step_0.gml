/// @description Move the player
if (!global.cutscene) {
	if (global.left_hold) {
		if (place_meeting(x - moveSpeed, y, obj_solid_parent))
			x += moveSpeed;
		
	    x -= moveSpeed;
		sprite_index = spriteLeft;
	    image_speed = moveSpeed / 15;
    }
    if (global.right_hold) {
		if (!global.left_hold) {
			if (place_meeting(x + moveSpeed, y, obj_solid_parent))
				x -= moveSpeed;
			
		    x += moveSpeed;
			sprite_index = spriteRight;
			image_speed = moveSpeed / 15;
		}
    }
    if (global.up_hold) {
		if (place_meeting(x, y - moveSpeed, obj_solid_parent))
			y += moveSpeed;
		
        y -= moveSpeed;
		sprite_index = spriteUp;
        image_speed = moveSpeed / 15;
    }
    if (global.down_hold) {
		if (!global.up_hold) {
			if (place_meeting(x, y + moveSpeed, obj_solid_parent))
				y -= moveSpeed;
			
	        y += moveSpeed;
			sprite_index = spriteDown;
			image_speed = moveSpeed / 15;
		}
    }
	
	if (global.up_hold) && (place_meeting(x, y - moveSpeed, obj_solid_parent)) {
		if (global.up_hold) && (global.down_hold) {
			sprite_index = (dance ? spr_player_up : spr_player_down);
			image_speed = moveSpeed / 15;
			if (alarm[0] < 0)
				alarm[0] = 1;
		}
	}
	
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
	
	if (x == xprevious) && (y == yprevious) {
	    image_speed = 0;
	    image_index = 0;
	}
	else {
		if (instance_exists(obj_encountersetup))
			obj_encountersetup.currentSteps++;
	}
}

if (x == xprevious) && (y == yprevious) {
	image_speed = 0;
	image_index = 0;
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