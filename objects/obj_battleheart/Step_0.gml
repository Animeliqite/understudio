if (moveable == true) {
    if (global.left_hold) {
        x -= move_speed;
    }
    if (global.right_hold) {
        x += move_speed;
    }
    if (global.up_hold) {
        y -= move_speed;
    }
    if (global.down_hold) {
        y += move_speed;
    }
    
    if (global.cancel_hold) {
        move_speed = 1.5
    }
    else {
        move_speed = 3;
    }
    
    if (collision_rectangle(obj_dborder.x, obj_dborder.y, obj_dborder.x - 5, obj_uborder.y, object_index, false, false))
        x -= move_speed;
    
    if (collision_rectangle(obj_uborder.x, obj_dborder.y, obj_uborder.x + 5, obj_uborder.y, object_index, false, false))
        x += move_speed;
    
    if (collision_rectangle(obj_uborder.x, obj_uborder.y, obj_dborder.x, obj_uborder.y + 5, object_index, false, false))
        y += move_speed;
    
    if (collision_rectangle(obj_dborder.x, obj_dborder.y, obj_uborder.x, obj_dborder.y - 5, object_index, false, false))
        y -= move_speed;
}

if (hurt == true) {
	if (inv > 0) {
		image_speed = 0.25;
		
		inv--;
	}
	else {
		hurt = false;
		inv = 30;
		
		image_speed = 0;
		image_index = 0;
	}
}