if (phase > 0) && (!instance_exists(obj_encnotif)) {
    var cam = obj_gamecamera;
	var player = obj_player;
	
	player.visible = false;
    
	draw_set_color(c_black);
    draw_rectangle(cam.x, cam.y, cam.x + (cam.width * cam.xScale), cam.y + (cam.height * cam.yScale), false);
    draw_set_color(c_white);

    if (blinkingPhase < 3)
		draw_sprite_ext(player.sprite_index, player.image_index, player.x, player.y, player.image_xscale, player.image_yscale, player.image_angle, player.image_blend, player.image_alpha);
	
    if (drawSoul)
        draw_sprite(spr_heartsmall, 0, drawSoulX, drawSoulY);

    draw_set_color(c_white);
}