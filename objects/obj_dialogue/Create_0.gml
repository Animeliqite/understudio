_x = camera_get_view_x(view_current);
_y = camera_get_view_y(view_current);
height = camera_get_view_height(view_current);
top = obj_player.y > height / 2;

messages = ["* Error."];
baseColor = c_white;
font = fnt_dialogue;
charWidth = 8;
charHeight = 18;
textEffect = 0; // 0 = none, 1 = shaking, 2 = wavy
textSpeed = 1;
textSound = [snd_text_default];

alarm[0] = 2;
alarm[1] = 1;

depth = depth_overworld.ui;