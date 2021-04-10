/// @description Wait for a while
x = 60 + sprite_xoffset;
y = 28 + sprite_yoffset;
image_index = 0;
image_speed = 0;
visible = false;
alarm[0] = 4;

fading = false;
write = false;
callonce = false;
timer = 0;

lastImage = spr_introimages_final;
lastImage_tween = -1;
lastImage_alpha = 0;
lastImage_x = 320;
lastImage_y = (y + sprite_yoffset) * 2;