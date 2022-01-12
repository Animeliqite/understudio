/// @description Border functionality

// Initialize the variables
var dw = display_get_width(), dh = display_get_height();
var ww = window_get_width(), wh = window_get_height();
var f = window_get_fullscreen();

// Border functionality
if (global.border) {
	if (f) {
		screenOffsetX = ((160 * borderWidth)) * (dw / 960);
		screenOffsetY = ((30 * borderHeight)) * (dh / 540);
		screenWidth = (dw - (2 * screenOffsetX)) / 640;
		screenHeight = screenWidth;
	}
	else {
		screenOffsetX = ((160 * borderWidth)) / (ww / 960);
		screenOffsetY = ((30 * borderHeight)) / (wh / 540);
		screenWidth = (ww - (2 * screenOffsetX)) / 640;
		screenHeight = screenWidth;
	}
}
else {
	if (f) {
        screenWidth = dh / 480;
        screenHeight = screenWidth;
        screenOffsetX = (dw - 640 * screenWidth) * 0.5; 
        screenOffsetY = 0;
	}
	else {
		screenOffsetX = 0;
		screenOffsetY = 0;
		screenWidth = ww / 640;
		screenHeight = screenWidth;
	}
}

// Draw GUI settings
display_set_gui_maximize(screenWidth, screenHeight, screenOffsetX, screenOffsetY);
display_set_gui_size(640 * screenWidth, 480 * screenHeight);