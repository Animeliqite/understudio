/// @description  scr_setbox( box_id );
/// @param  box_id 
function scr_setbox(argument0) {

	var box_id = argument0;

	global.boxplacement = box_id;

	switch (global.boxplacement) {
	    case 0: // Dialogue Box
	        global.boxplacement_x[0] = 32;
	        global.boxplacement_y[0] = 250;
	        global.boxplacement_x[1] = 609;
	        global.boxplacement_y[1] = 385;
	        break;
        
	    case 1: // Small Box
	        global.boxplacement_x[0] = 237;
	        global.boxplacement_y[0] = 250;
	        global.boxplacement_x[1] = 397;
	        global.boxplacement_y[1] = 385;
	        break;
        
	    case 2: // Standard Box
	        global.boxplacement_x[0] = 217;
	        global.boxplacement_y[0] = 180;
	        global.boxplacement_x[1] = 417;
	        global.boxplacement_y[1] = 385;
	        break;
        
	    case 3: // Tower Box
	        global.boxplacement_x[0] = 217;
	        global.boxplacement_y[0] = 125;
	        global.boxplacement_x[1] = 417;
	        global.boxplacement_y[1] = 385;
	        break;
        
	    case 4: // Hyper-Goner Box
	        global.boxplacement_x[0] = -5;
	        global.boxplacement_y[0] = -5;
	        global.boxplacement_x[1] = room_width + 5;
	        global.boxplacement_y[1] = room_height + 5;
	        break;
	}




}
