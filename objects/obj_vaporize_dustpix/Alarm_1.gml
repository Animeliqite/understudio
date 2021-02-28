if (image_alpha > 0)
	image_alpha -= 0.08;
else
	instance_destroy();

x += horizontal_speed;
y -= acceleration;

acceleration += base_acceleration;
alarm[1] = freeze;
