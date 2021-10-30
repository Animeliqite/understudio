/// @description  scr_setbox( box_id );
/// @param  box_id 
function scr_setbox(argument0) {

	var box_id = argument0;

	global.board = box_id;

	switch (global.board) {
	    case 0: // Dialogue Box
	        global.boardX1 = 32;
	        global.boardY1 = 250;
	        global.boardX2 = 609;
	        global.boardY2 = 385;
	        break;
        
	    case 1: // Small Box
	        global.boardX1 = 237;
	        global.boardY1 = 250;
	        global.boardX2 = 397;
	        global.boardY2 = 385;
	        break;
        
	    case 2: // Standard Box
	        global.boardX1 = 217;
	        global.boardY1 = 180;
	        global.boardX2 = 417;
	        global.boardY2 = 385;
	        break;
        
	    case 3: // Tower Box
	        global.boardX1 = 217;
	        global.boardY1 = 125;
	        global.boardX2 = 417;
	        global.boardY2 = 385;
	        break;
        
	    case 4: // Hyper-Goner Box
	        global.boardX1 = -5;
	        global.boardY1 = -5;
	        global.boardX2 = room_width + 5;
	        global.boardY2 = room_height + 5;
	        break;
	}




}
