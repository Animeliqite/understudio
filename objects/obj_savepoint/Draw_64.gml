var l = global.left_press;
var r = global.right_press;
var z = global.confirm;
var c = global.cancel;
var sel_max = 1;

if (show_ui) {
	draw_box(108, 98, 530, 270);
	draw_set_font(fnt_dialogue);
	draw_set_color((state == 1 ? c_yellow : c_white));
	draw_text(140, 160, room_getname(roomname));
	draw_text(140, 120, name);
	draw_text(lv_pos, 120, get_message("saveInfo_LV") + " " + string(love));
	
	draw_set_halign(fa_right);
	draw_text(500, 120, string(minutes) + ":" + (seconds < 10 ? "0" : "") + string(seconds));
	
	draw_set_halign(fa_left);
	
	if (seconds == 60)
		seconds = 59;
	
	if (state == 0) {
		draw_sprite_ext(spr_heartsmall, 0, (selection == 0 ? 140 : 342), 225, 2, 2, 0, c_white, 1);
		
		draw_text(170, 220, get_message("saveOption_0")); // Save
		draw_text(372, 220, get_message("saveOption_1")); // Return
	
		if (l) {
			if (selection > 0)
				selection--;
			else
				selection = sel_max;
			audio_play_sound(snd_menuswitch, 0, false);
		}
		if (r) {
			if (selection < sel_max)
				selection++;
			else
				selection = 0;
			audio_play_sound(snd_menuswitch, 0, false);
		}
	
		if (z) {
			switch (selection) {
				case 0: // Save
					state = 1;
					audio_play_sound(snd_save, 0, false);
					
					minutes = global.minutes;
					seconds = global.seconds;
					roomname = room;
					global.currentroom = room;
					name = global.name;
					love = global.lv;
					
					scr_save();
					break;
				case 1: // Return
					global.cutscene = false;
					show_ui = false;
					interact_amount = 0;
					state = 0;
					
					alarm[1] = 2; // Cooldown
					break;
			}
		}
		if (c) {
			global.cutscene = false;
			show_ui = false;
			interactable = true;
			interact_amount = 0;
			state = 0;
		}
	}
	else if (state == 1) {
		draw_set_color(c_yellow);
		draw_text(170, 220, get_message("saveResult")); // File saved.
		
		if (z) {
			global.cutscene = false;
			show_ui = false;
			interact_amount = 0;
			state = 0;
			
			alarm[1] = 2; // Cooldown
		}
	}
}