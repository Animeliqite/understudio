if (ready == true) {
	if (phase == 0) {
		mus_loop_safe(5, "gameover", 1, 1);
		
		phase = 1;
	}
	if (phase == 1) {
		if (alpha < 1)
			alpha += 0.01;
		else
			phase = 2;
 	}
	if (phase == 2) {
		if (!instance_exists(obj_typer)) && (text_no < text_end)
			create_text(120, room_height - 200, "GAME-OVER", c_white, text[text_no], true);
		else if (!instance_exists(obj_typer)) && (text_no >= text_end)
			phase = 3;
		
		if (instance_exists(obj_typer)) {
			if (obj_typer.writing == false) && (global.confirm) {
				text_no++;
			}
		}
	}
	if (phase == 3) {
		mus_set_volume(5, 0, 1500);
		
		if (alpha > 0)
			alpha -= 0.025;
		
		if (alarm[3] < 0)
			alarm[3] = 60;
	}
	if (phase == 4) {
		if (!instance_exists(obj_persistent_fade)) { 
		    var fade = instance_create(0, 0, obj_persistent_fade);
		    fade.targetRoom = global.currentroom;
		}
		
		global.spawn = -1;
		global.cutscene = true;
	}
}