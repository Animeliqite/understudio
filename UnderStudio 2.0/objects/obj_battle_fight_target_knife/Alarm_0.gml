/// @description Fade out the target

targetFade = true;

execute_tween(id, "image_xscale", 0.25, "linear", 0.5, false);
execute_tween(id, "image_alpha", 0, "linear", 0.5, false);

alarm[1] = 30;