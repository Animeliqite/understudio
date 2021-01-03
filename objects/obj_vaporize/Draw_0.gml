if (ready == true) {
	// With the help from Colinator27!
	
    var buffer = buffer_getpixel_begin(surface);
    var body = global.monster.body[obj_battlecontroller.sel[1]];
    
    for (var _y = 0; _y < body.sprite_height; _y++) {
        for (var _x = 0; _x < body.sprite_width; _x++) {
            pixel = buffer_getpixel_ext(buffer, _y, _x, body.sprite_width, body.sprite_height);
        }
    }
	
	show_debug_message(pixel);
	
    buffer_delete(buffer);
}