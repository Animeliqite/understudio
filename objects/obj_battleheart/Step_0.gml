if (moveable == true) {
    if (input.left) {
        x -= move_speed;
    }
    if (input.right) {
        x += move_speed;
    }
    if (input.up) {
        y -= move_speed;
    }
    if (input.down) {
        y += move_speed;
    }
    
    if (input.cancel_h) {
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

