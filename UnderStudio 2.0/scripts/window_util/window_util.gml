// This script returns a struct by checking the current window type.
function window_get_size() {
	if (!global.border) return {w: 640, h: 480};
	else return {w: 960, h: 540};
}

// This script updates the window size with the width and the height got from the getter script.
function window_update_size() {
	var size = global.windowSize;
	
	window_set_size(size.w, size.h);
	with (obj_gamehandler) alarm[0] = 1;
}

// This script creates a window animation
function window_create_animation(type, intensity, posX, posY) {
	switch (type) {
		case ANIMATION_TYPE.SHAKY:
			window_set_position(posX + irandom(intensity), posY + irandom(intensity));
			break;
		case ANIMATION_TYPE.PARTLY_SHAKING:
			randomize();
			var chances = random(100);
			
			window_set_position(posX + (chances >= 98 ? irandom(intensity) : 0), 
								posY + (chances >= 98 ? irandom(intensity) : 0));
			break;
		case ANIMATION_TYPE.WAVY:
			window_set_position(posX + (sin(current_time / 1000 * pi) * intensity), posY + (cos(current_time / 1000 * pi) * intensity));
			break;
	}
}