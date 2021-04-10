/// @description Fade to black
if (image_alpha > 0) {
	image_alpha -= 0.125;
	
	if (!fading) {
		if (alarm[1] < 0)
			alarm[1] = 1;
	}
}