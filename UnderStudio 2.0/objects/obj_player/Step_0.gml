/// @description Functionality

// Initialize the variables
var u = BT_UP, d = BT_DOWN, l = BT_LEFT, r = BT_RIGHT;
var collisionLeft = place_meeting(x - moveSpeed, y, obj_solidparent);
var collisionRight = place_meeting(x + moveSpeed, y, obj_solidparent);
var collisionUp = place_meeting(x, y - moveSpeed, obj_solidparent);
var collisionDown = place_meeting(x, y + moveSpeed, obj_solidparent);
// Make it so that two buttons are not pressed at the same time
if (l && r) r = false;
if (u && d) d = false;

if (l && d) {
	currDirDiagonal = 225;
} else if (l && u) {
	currDirDiagonal = 135;
} else if (r && d) {
	currDirDiagonal = 315;
} else if (r && u) {
	currDirDiagonal = 45;
} else {
	currDirDiagonal = currDir;
}

// Check what buttons are pressed
if (canMove) {
	if (u) {
		if (!collisionUp)
			y -= moveSpeed;
		if (!l && !r) || (currDir == DIR_DOWN)
			currDir = DIR_UP;
	}

	if (d) {
		if (!collisionDown)
			y += moveSpeed;
		if (!l && !r) || (currDir == DIR_UP)
			currDir = DIR_DOWN;
	}

	if (l) {
		if (!collisionLeft)
			x -= moveSpeed;
		if (!u && !d) || (currDir == DIR_RIGHT)
			currDir = DIR_LEFT;
	}

	if (r) {
		if (!collisionRight)
			x += moveSpeed;
		if (!u && !d) || (currDir == DIR_LEFT)
			currDir = DIR_RIGHT;
	}
	
	// Check if the player's moving
	if (x != xprevious || y != yprevious) {
		stepsTaken++; // Increase the current steps taken
	}
}

// Animating the object
if (x != xprevious || y != yprevious) {
	if (image_speed == 0) image_index = 1;
	image_speed = moveSpeed / 15;
	
	xprevious = x;
	yprevious = y;
}
else {
	image_index = 0;
	image_speed = 0;
}