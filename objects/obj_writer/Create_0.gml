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

skip = false;
skippable = true;
confirmable = true;

face = "";
faceEmotion = 0;
faceIndex = 0;
faceSurface = -1;

mustBeInBounds = true;
textBounds = [0, 0, display_get_gui_width(), display_get_gui_height()];

_x = x;
_y = y;

depth = depth_overworld.ui_high;