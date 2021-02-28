/// @description  Turn Preparation Start

if (monsterhp[0] > 0) { 
	scr_setbox(1);
	scr_centerheart();

	battle_setturntime(160);

	textPhase[0]++;

	var bubble = instance_create(body[0].x + 80, body[0].y, obj_speechbubble);

	if (textPhase[0] == 1) {
	    bubble.text[0] = text[0,0];
	    bubble.sprite[0] = spr_speechbubble_left_wide;
    
	    bubble.text[1] = text[0,1];
	    bubble.sprite[1] = spr_speechbubble_left_wide;
    
	    bubble.text_end = 1;
	}
	if (textPhase[0] == 2) {
	    bubble.text[0] = text[0,2];
	    bubble.sprite[0] = spr_speechbubble_left_wide;
    
	    bubble.text[1] = text[0,3];
	    bubble.sprite[1] = spr_speechbubble_left_wide;
    
	    bubble.text[2] = text[0,4];
	    bubble.sprite[2] = spr_speechbubble_left_wide;
    
	    bubble.text_end = 2;
	}
	if (textPhase[0] >= 3) {
	    bubble.text[0] = text[0,5];
	    bubble.sprite[0] = spr_speechbubble_left_wide;
    
	    bubble.text_end = 0;
	}
}
else {
	instance_create(body[0].x, body[0].y, obj_vaporize);
	body[0].visible = false;
	obj_battlecontroller.menuno = 10000;
}