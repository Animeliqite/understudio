if (instance_exists(col)) {
	var w = col.sprite_width * col.image_xscale, h = col.sprite_height * col.image_yscale;
	var _bbox_left = col.bbox_left, _bbox_top = col.bbox_top;
	
	if (state == 0) {
		if (!dust_alt) {
			if (anim_h < h) {
				anim_h += yscale * 2;
			}
			else {
				state = 1;
			}
	
			for (var i = 0; i < w; i++) {
				if (position_meeting(_bbox_left + i, _bbox_top + anim_h, col)) {
					instance_create_depth(_bbox_left + i, _bbox_top + anim_h, depth, obj_battlevaporpx);
				}
			}
		}
		else {
			if (anim_h < h) {
				anim_h += yscale * 2;
			}
			else {
				state = 1;
			}
	
			for (var i = 0; i < w; i++) {
				if (position_meeting(_bbox_left + i, _bbox_top + anim_h, col)) {
					if (!dust_is_colliding) {
						dust_curr_dir = random(360);
						dust_curr_spd = 2 + random(2);
						dust_is_colliding = true;
					}
					
					var _dust = instance_create_depth(_bbox_left + i, _bbox_top + anim_h, depth, obj_battlevaporpx);
					_dust.direction = dust_curr_dir;
					_dust.speed = dust_curr_spd;
				}
				else {
					if (dust_is_colliding) {
						dust_is_colliding = false;
					}
				}
			}
		}
	}
	else if (state == 1) {
		instance_destroy(col);
		instance_destroy();
	}
}