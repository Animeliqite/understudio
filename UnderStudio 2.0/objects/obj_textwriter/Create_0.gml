/// @description Initialize

text			= "";								// The text that the writer is going to write.
written			= "";								// The current written text
currentPos		= 0;								// The current text position
textSpeed		= 0;								// The speed of the writing process

font			= fnt_main;							// The font the text is going to be written with
color			= c_white;							// The color the text is going to be written with
voice			= [snd_defaultvoice];				// The sound that will play when the writer writes a letter
alpha			= 1;								// The alpha the text is going to be written with

drawText		= true;								// Decides whether to draw the text on the screen
skipText		= false;							// Decides whether to skip the writing process
skippable		= true;								// Is the text skippable?
completed		= false;							// A getter-purposed variable that checks whether the writer has completed writing
holdTimer		= 0;								// The timer that the writer is going to wait before adding a letter

scaleX			= 1;								// The X scale of the letters
scaleY			= 1;								// The Y scale of the letters
charWidth		= global.mainFontWidth;				// The width of an each character
charHeight		= global.mainFontHeight;			// The height of an each character

formatText		= true;								// Should the writer format the text?
punctuations	= [".", ",", ":", ";", "!", "?"];	// Text punctuations needed for formatting
alarm[0]		= 1;								// Trigger an alarm to add formatting