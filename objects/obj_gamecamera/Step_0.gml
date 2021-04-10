if (!instance_exists(target)) {
	camera_set_view_target(gameCamera, noone);
	camera_set_view_pos(gameCamera, x, y);
}
else {
	camera_set_view_target(gameCamera, target);
	x = camera_get_view_x(gameCamera);
	y = camera_get_view_y(gameCamera);
}

camera_set_view_size(gameCamera, width * xScale, height * yScale);
camera_set_view_angle(gameCamera, angle);