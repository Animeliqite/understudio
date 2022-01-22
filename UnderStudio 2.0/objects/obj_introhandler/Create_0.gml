/// @description Initialize

// BUILT-IN
image_speed		= 0;	// Set the image speed to 0 so that the image index won't increment automatically
image_index		= 0;	// Set the image index to 0

// SYSTEM
timer			= 0;	// The main timer of this object
state			= 0;	// The current state of this object
subState		= 0;	// The current sub state of this object

// TEXT
textX			= 120;	// The X coordinate of where the text is going to be written
textY			= 320;	// The Y coordinate of where the text is going to be written
textNo			= 0;	// The current text number
text			= [
	"Long ago, two races#ruled over EARTH:#HUMANS and MONSTERS.",
	"One day, war broke#out between the#two races.",
	"After a long battle,#the humans were#victorious.",
	"They sealed the monsters#underground with a magic#spell.",
	"Many years later...",
	"      MT. EBOTT#         201X",
	"Legends say that those#who climb the mountain#never return.",
	"`p6`",
	"`p6`",
	"`p6`",
	"`p9``p9``p9``p9``p9``p8`"
];

// WRITER
runText					= function (text) {
	writer				= instance_create_depth(0, 0, 0, obj_textwriter);
	writer.text			= text + "`p3`";
	writer.voice		= [snd_alternatevoice];
	writer.textSpeed	= 1;
	writer.drawText		= false;
	writer.skippable	= false;
}

// MISC
writer			= noone;				// The writer object
fading			= false;				// Is the object fading?
musManager		= global.musicManager;	// The music manager
finalPanelX		= x;					// The X coordinate of the final panel
finalPanelY		= y + 138;				// The Y coordinate of the final panel
finalPanelTimer	= 0;					// The timer of the final panel
runText(text[textNo]);
music = musManager.Play(musManager.Load("story"), 1, 0.91);