/// @description  Work with some variables

if (enabled) {
    border_xscale = window_get_width() / 960;
    border_yscale = window_get_height() / 540;
    
    screen_xscale = border_xscale / 2;
    screen_yscale = border_yscale / 2;
    
    screen_xoffset = floor(160 * border_xscale);
    screen_yoffset = floor(30 * border_yscale);
}
else {
    border_xscale = window_get_width() / 640;
    border_yscale = window_get_height() / 480;
    
    screen_xscale = border_xscale / 2;
    screen_yscale = border_yscale / 2;
    
    screen_xoffset = 0;
    screen_yoffset = 0;
}

if (next_sprite != -1) {
    if (current_sprite_alpha > 0) {
        current_sprite_alpha -= 0.005;
        next_sprite_alpha += 0.005;
    }
    else {
        current_sprite = next_sprite;
        next_sprite = -1;
        current_sprite_alpha = 1;
        next_sprite_alpha = 0;
    }
}

display_set_gui_size(640, 480);
display_set_gui_maximise(screen_xscale, screen_yscale, screen_xoffset, screen_yoffset);

