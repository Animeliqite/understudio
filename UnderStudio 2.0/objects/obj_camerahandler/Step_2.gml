/// @description Functionality

var offsetX = camWidth / camScaleX;
var offsetY = camHeight / camScaleY;

// Compute desired non-lerped (real) position
realX = median(0, (currTarget != noone ? currTarget.x - offsetX / 2 : posX), room_width - offsetX);
realY = median(0, (currTarget != noone ? currTarget.y - offsetY / 2 : posY), room_height - offsetY);

// Snap immediately at room start
if (!camera_initialized) {
    x = realX;
    y = realY;
    camera_initialized = true;
} else {
    x = lerp(x, realX, posLagX);
    y = lerp(y, realY, posLagY);
}

posCenterX = x + (offsetX / 2);
posCenterY = y + (offsetY / 2);
isTweening = (tween_exists(id, "posX") || tween_exists(id, "posY"));

if (!isTweening) {
    posX = realX; // Important: use true position
    posY = realY;
}

camera_set_view_pos(cam, x, y);
camera_set_view_angle(cam, camAngle);
camera_set_view_size(cam, camWidth / camScaleX, camHeight / camScaleY);