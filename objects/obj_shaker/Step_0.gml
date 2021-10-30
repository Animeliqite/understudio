target.x = target.x + shake_x;

if (shake_x < 0)
    shake_x = -(shake_x + 2);
else
    shake_x = -shake_x;

if (shake_x == 0)
    instance_destroy();