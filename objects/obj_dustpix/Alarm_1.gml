/// @description Process movement

// Suddenly, this dust doesn't feel so good...
if (image_alpha > 0)
    image_alpha -= 0.08;
else
{
    instance_destroy();
	exit;
}
		
x += horzSpeed;
y -= accel;
accel += baseAccel;

alarm[1] = freeze;
