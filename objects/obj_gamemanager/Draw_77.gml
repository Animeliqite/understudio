/// @description Draw the border, then the application surface

if (borderEnabled) {
    application_surface_draw_enable(false);
    draw_sprite_ext(currentSprite, 0, 0, 0, borderXScale, borderYScale, 0, c_white, currentSpriteAlpha);
    
	if (nextSprite != -1) {
        draw_sprite_ext(nextSprite, 0, 0, 0, borderXScale, borderYScale, 0, c_white, nextSpriteAlpha);
    }
	
    draw_set_alpha(1);
    draw_surface_ext(application_surface, screenXOffset, screenYOffset, screenXScale, screenYScale, 0, c_white, 1);
}
else {
    application_surface_draw_enable(true);
}

