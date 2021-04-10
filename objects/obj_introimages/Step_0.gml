/// @description Intro functionality
if (instance_exists(obj_writer)) {
	if (callonce) {
		timer = 0;
		image_index++;
		obj_writer.isDone = false;
		obj_writer.messageIndex++;
		obj_writer.messageCharPos = 0;
		obj_writer.drawString = "";
		callonce = false;
	}
	
	if (obj_writer.isDone) && (write) {
		if (!fading) {
			if (obj_writer.messageIndex < array_length(obj_writer.messages) - 1) {
				if (image_alpha != 0) {
					if (alarm[1] < 0)
						alarm[1] = 1;
				}
				else
					callonce = true;
			}
			else {
				if (image_alpha != 0) {
					if (alarm[1] < 0)
						alarm[1] = 1;
				}
				else {
					room_goto(room_title);
					mus_stop(0);
				}
				mus_set_volume(0, 0, 1000);
			}
		}
	}
	
	if (!fading) && (!obj_writer.isDone) {
		if (image_alpha != 1) {
			if (alarm[2] < 0)
				alarm[2] = 1;
		}
	}
	
	switch (obj_writer.messageIndex) {
		case 11:
			timer++;
			lastImage_alpha = image_alpha;
			if (timer == room_speed * 2)
				lastImage_tween = TweenFire(self, EaseLinear, TWEEN_MODE_ONCE, false, 0, room_speed * 8, "lastImage_y", lastImage_y, ((y + sprite_yoffset) * 2) + (y * 2) + sprite_get_height(lastImage));
	}
}

if (global.confirm) && (fading == false) && (write) {
	mus_set_volume(0, 0, 1000);
	instance_destroy(obj_writer);
	fading = true;
}
if (fading == true) {
	if (image_alpha != 0) {
		if (alarm[1] < 0)
			alarm[1] = 1;
	}
	else {
		room_goto(room_title);
		mus_stop(0);
	}
}