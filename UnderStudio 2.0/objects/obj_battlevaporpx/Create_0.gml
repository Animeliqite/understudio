direction = random(360);
speed = 2 + random(2);

image_xscale = 2;
image_yscale = 2;

execute_tween(id, "speed", 0, "linear", 15, false);
execute_tween(id, "image_alpha", 0, "linear", 15, false);

alarm[0] = 15;