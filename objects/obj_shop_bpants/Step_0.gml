if (faceNo == 0) {
    sprite_index = spr_bpants_face0;
    
    y = ystart;
    
    drawHands = false;
    drawSmoke = false;
}
if (faceNo == 1) {
    sprite_index = spr_bpants_face6;
    
    y = ystart - 5;
    
    image_speed = 0.2;
    
    drawHands = false;
    drawSmoke = true;
}
if (faceNo == 2) {
    sprite_index = spr_bpants_face1;
    
    y = ystart - 5;
    
    x = random_range(xstart + 0.5, xstart - 0.5);
    y = random_range(ystart + 0.5, ystart - 0.5);
    
    image_speed = 0.2;
    
    drawHands = false;
    drawSmoke = false;
}
if (faceNo == 3) {
    sprite_index = spr_bpants_face3;
    
    y = ystart - 5;
    
    image_speed = 0.2;
    
    drawHands = true;
    drawSmoke = false;
}

event_inherited();

if (menu == 0) {
    faceNo = 0;
}

if (menu == 2) {
    faceNo = 3;
}
if (menu >= 888) && (menu < 999) {
    faceNo = 0;
}

if (menu >= 999) {
    faceNo = 1;
}

