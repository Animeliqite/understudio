// This script returns a struct by checking the current window type.
function WindowUtil() constructor {
	ExecuteTween = function (type = ANIMATION_TYPE.SHAKY, intensity = 1, posX = window_get_x(), posY ) {
		if (!obj_cutscenehandler.gotOnce) {
			var finalPosX = posX, finalPosY = posY;
			obj_cutscenehandler.gotOnce = true;
		}
		else {
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
	}
	
	// This script gets the window size by checking if borders are enabled or not.
	GetSize = function () {
		if (!global.border) return {w: 640, h: 480};
		else return {w: 960, h: 540};
	}
	
	// This script updates the window size with the width and the height got from the getter script.
	UpdateSize = function () {
		var size = global.windowSize;
	
		window_set_size(size.w, size.h);
		with (obj_gamehandler) alarm[0] = 1;
	}
}