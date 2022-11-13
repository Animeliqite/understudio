/// @description Functionality

// Initialize the variables
var offsetX = camWidth / camScaleX, offsetY = camHeight / camScaleY;
x = lerp(x, median(0, (currTarget == noone ? posCenterX - offsetY / 2 : currTarget.x - offsetX / 2), room_width - offsetX), posLagX);
y = lerp(y, median(0, (currTarget == noone ? posCenterY - offsetY / 2 : currTarget.y - offsetY / 2), room_height - offsetY), posLagY);

// Make it so that moving the camera is easier
posCenterX = x + (offsetX / 2);
posCenterY = y + (offsetY / 2);

// Update the built-in functions with the variables
camera_set_view_pos(cam, x, y);
camera_set_view_angle(cam, camAngle);
camera_set_view_size(cam, camWidth / camScaleX, camHeight / camScaleY);