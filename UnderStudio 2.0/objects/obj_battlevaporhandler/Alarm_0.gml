var inst = id;

col = instance_create_depth(x, y, depth, obj_battlevaporcollision);

with (col) {
	sprite_index = inst.sprite;
	image_xscale = inst.xscale;
	image_yscale =inst.yscale;
};

state = 0;