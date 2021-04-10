/// @description Adjust the border

if (borderEnabled) {
    borderXScale = window_get_width() / 960;
    borderYScale = window_get_height() / 540;
    
    screenXScale = borderXScale / 2;
    screenYScale = borderYScale / 2;
    
    screenXOffset = floor(160 * borderXScale);
    screenYOffset = floor(30 * borderYScale);
}
else {
    borderXScale = window_get_width() / 640;
    borderYScale = window_get_height() / 480;
    
    screenXScale = borderXScale / 2;
    screenYScale = borderYScale / 2;
    
    screenXOffset = 0;
    screenYOffset = 0;
}

if (nextSprite != -1) {
    if (currentSpriteAlpha > 0) {
        currentSpriteAlpha -= 0.005;
        nextSpriteAlpha += 0.005;
    }
    else {
        currentSprite = nextSprite;
        nextSprite = -1;
        currentSpriteAlpha = 1;
        nextSpriteAlpha = 0;
    }
}

display_set_gui_size(640, 480);
display_set_gui_maximise(screenXScale * 2, screenYScale * 2, screenXOffset, screenYOffset);