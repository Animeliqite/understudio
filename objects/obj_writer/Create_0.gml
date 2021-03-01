/// @description Set the variables

messages = ["* Error."];
messageIndex = 0;
messageCharPos = 0;
drawString = "";
baseColor = c_white;
font = fnt_dialogue;
charSiner = 0;
charWidth = 8;
charHeight = 18;
textEffect = 0; // 0 = none, 1 = shaking, 2 = wavy
textSpeed = 1;
textSound = [noone];
pauseTimer = 0;
isDone = false;

mustBeInBounds = false;
textBounds = [0, 0, camera_get_view_width(view_current), camera_get_view_height(view_current)];

_x = x;
_y = y;

depth = depth_overworld.ui_high;