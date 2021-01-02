if (phase == 3) {
    x = obj_player.x - (sprite_get_width(spr_heartsmall) / 2);
    y = obj_player.y - (sprite_get_height(spr_heartsmall) / 2);
    
    draw_soul_x = x;
    draw_soul_y = y;
    
    audio_play_sound(snd_enc2, 10, false);
    
    speed = distance_to_point(soul_target_x, soul_target_y) / 20;
    
    phase = 4;
}
if (phase == 4) {
    
    draw_soul_x = x;
    draw_soul_y = y;
    
    draw_soul = true;
    
    direction = point_direction(x, y, soul_target_x, soul_target_y);
    
    if (point_distance(x, y, soul_target_x, soul_target_y) < 5) {
        phase = 5;
    }
}
if (phase == 5) {
    if (alarm[1] < 0) {
        alarm[1] = 8;
    }
}

