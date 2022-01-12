/// @description Initialize

text = "";
written = "";
currentPos = 0;
textSpeed = 0;

font = fnt_main;
color = c_white;
voice = [snd_defaultvoice];
alpha = 1;

drawText = true;
skipText = false;
completed = false;
holdTimer = 0;

scaleX = 1;
scaleY = 1;
charWidth = global.mainFontWidth;
charHeight = global.mainFontHeight;