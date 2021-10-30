if (moveable == true) {
	var bm = obj_battlemanager;
	move_speed = (global.cancel_hold ? 1.5 : 3);
	
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
	
    if (collision_rectangle(bm.boardX2, bm.boardY2, bm.boardX2 - 5, bm.boardY1, object_index, false, false))
        x -= move_speed;
    
    if (collision_rectangle(bm.boardX1, bm.boardY2, bm.boardX1 + 5, bm.boardY1, object_index, false, false))
        x += move_speed;
    
    if (collision_rectangle(bm.boardX1, bm.boardY1, bm.boardX2, bm.boardY1 + 5, object_index, false, false))
        y += move_speed;
    
    if (collision_rectangle(bm.boardX2, bm.boardY2, bm.boardX1, bm.boardY2 - 5, object_index, false, false))
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