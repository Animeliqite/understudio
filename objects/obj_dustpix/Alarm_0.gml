/// @description End of life

if (type == 1)
{
    // This is a non-white pixel, and as such it doesn't fade away
    instance_destroy();
    exit;
}
    
// Most accurate properties
horzSpeed = random(4) - 2;
baseAccel = random(0.5) + 0.2;

alarm[1] = freeze;