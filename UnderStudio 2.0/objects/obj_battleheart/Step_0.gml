/// @description Functionality

// Make the soul move and collide with the solid object
move_and_collide(dirX, dirY, collideWith);

if (obj_battlehandler.state == BATTLE_STATE_IN_TURN) {
	switch (colorBlend) {
		case c_red:
			// Add the basic movement in
			basicMovement();
			break;
	}
}