if (collision) {
	if (smoothCollision) {
		solidObj = instance_create_depth(bbox_left, bbox_top, 0, obj_solid);
		solidObj.image_xscale = abs((bbox_right - bbox_left) / 20);
		solidObj.image_yscale = abs((bbox_top - bbox_bottom) / 20);
	}
}