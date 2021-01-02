/// @description  Draw the border, then the application surface

if (enabled) {
    application_surface_draw_enable(false);
    
    draw_sprite_ext(current_sprite, 0, 0, 0, border_xscale / 2, border_yscale / 2, 0, c_white, current_sprite_alpha);
    
    if (next_sprite != -1) {
        draw_sprite_ext(next_sprite, 0, 0, 0, border_xscale / 2, border_yscale / 2, 0, c_white, next_sprite_alpha);
    }
    
    draw_set_alpha(1);
    draw_surface_ext(application_surface, screen_xoffset, screen_yoffset, screen_xscale, screen_yscale, 0, c_white, 1);
}
else {
    application_surface_draw_enable(true);
}

