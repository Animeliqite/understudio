function border_enable( enabled ){
	switch (enabled) {
		case true:
			global.border_enabled = true;
			window_set_size(950, 540);
			break;
		
		case false:
			global.border_enabled = false;
			window_set_size(640, 480);
			break;
	}
}