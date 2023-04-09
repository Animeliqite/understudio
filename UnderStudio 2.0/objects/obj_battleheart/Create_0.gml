/// @description Initialize

// VARIABLES
moveSpeed	= 3;				// Move speed
collideWith	= obj_solidparent;	// Which object will the soul collide with?

// ADVANCED
dirX		= 0;				// The X direction
dirY		= 0;				// The Y direction
colorBlend	= c_red;			// The color blend
image_index	= 0;				// The image index
image_speed	= 0;				// The image speed

// FUNCTIONS
basicMovement = function () {
	dirX = moveSpeed * (BT_RIGHT ? 1 : -1);
	dirY = moveSpeed * (BT_UP ? -1 : 1);
	
	if (!BT_LEFT && !BT_RIGHT) dirX = 0;
	if (!BT_UP && !BT_DOWN) dirY = 0;
}