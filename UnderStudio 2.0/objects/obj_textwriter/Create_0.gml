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
holdTimer = 0;
completed = false;

scaleX = 1;
scaleY = 1;
charWidth = global.mainFontWidth;
charHeight = global.mainFontHeight;