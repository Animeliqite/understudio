if (image_alpha > 0)
    image_alpha -= 0.05;
else
    instance_destroy();

randomize();

x = lerp(x, xstart + rndm_x, 0.25);
y = lerp(y, ystart + rndm_y, 0.25);

