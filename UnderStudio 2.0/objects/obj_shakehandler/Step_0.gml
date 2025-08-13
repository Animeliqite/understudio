if (shake_active && instance_exists(shake_target)) {
	var sx = 0;
	var sy = 0;

	// Horizontal shake
	if (shake_curr_x > 0) {
		if (shake_random_x) {
			sx = random_range(-shake_x, shake_x);
		} else {
			sx = shake_dir_x * shake_curr_x;
			shake_dir_x *= -1;
			shake_curr_x = max(0, shake_curr_x - shake_decrease_x);
		}
	}

	// Vertical shake
	if (shake_curr_y > 0) {
	    if (shake_random_y) {
			sy = random_range(-shake_y, shake_y);
	    } else {
		    sy = shake_dir_y * shake_curr_y;
		    shake_dir_y *= -1;
		    shake_curr_y = max(0, shake_curr_y - shake_decrease_y);
	    }
	}

	// Apply offset
	shake_target.x += sx;
	shake_target.y += sy;

	// Stop when both done
	if (shake_curr_x <= 0 && shake_curr_y <= 0) {
		shake_active = false;
		instance_destroy(); // auto-remove when finished
	}
}