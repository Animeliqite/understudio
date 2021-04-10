gameCamera = camera_create_view(x, y, width * xScale / 2, height * yScale / 2, angle, target, -1, -1, width * xScale / 2, height * yScale / 2);
view_camera[view_current] = gameCamera;
x = 0;
y = 0;