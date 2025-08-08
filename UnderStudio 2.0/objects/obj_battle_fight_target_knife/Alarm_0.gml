/// @description Fade out the target

targetFade = true;

execute_tween(id, "image_xscale", 0.25, "linear", 15, false);
execute_tween(id, "image_alpha", 0, "linear", 15, false);

alarm[1] = 30;