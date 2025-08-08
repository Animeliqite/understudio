/// @description Reset Settings

camWidth		= 640; // The camera width
camHeight		= 480; // The camera height

posX = x;
posY = y;
realX = x;
realY = y;
posLagX			= 1; // X Lerp amount. Can only be set between 0 and 1.
posLagY			= 1; // Y Lerp amount. Can only be set between 0 and 1.
posCenterX		= x; // The center X position of what the camera is showing
posCenterY		= y; // The center Y position of what the camera is showing

camAngle		= 0; // The angle of the camera
camScaleX		= 1; // Scales down (or up) the width of the camera
camScaleY		= 1; // Scales down (or up) the height of the camera
currTarget		= noone; // The object that the camera is following with

shake_x			= 0; // Max horizontal shake
shake_y			= 0; // Max vertical shake
shake_random_x	= false; // true = random X each step
shake_random_y	= false; // true = random Y each step
shake_decrease_x = 1; // How much X intensity drops per bounce
shake_decrease_y = 1; // How much Y intensity drops per bounce

shake_curr_x	= 0; // Current X intensity
shake_curr_y	= 0; // Current Y intensity
shake_dir_x		= 1; // Flips +/–
shake_dir_y		= 1; // Flips +/–

isTweening = false;
camera_initialized = false;