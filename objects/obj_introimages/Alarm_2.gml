/// @description Fade from black
if (image_alpha < 1) {
	image_alpha += 0.125;
	
	if (!fading) {
		if (alarm[2] < 0)
			alarm[2] = 1;
	}
}