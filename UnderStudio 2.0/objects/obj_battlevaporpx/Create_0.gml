dir = 0;
spd = 0;

image_xscale = 2;
image_yscale = 2;

execute_tween(id, "speed", 0, "linear", 15, false);
execute_tween(id, "image_alpha", 0, "linear", 15, false);

alarm[0] = 15;