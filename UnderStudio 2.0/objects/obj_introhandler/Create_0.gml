/// @description Initialize

// BUILT-IN
image_speed		= 0;										// Set the image speed to 0 so that the image index won't increment automatically
image_index		= 0;										// Set the image index to 0

// SYSTEM
timer			= 0;										// The main timer of this object
state			= 0;										// The current state of this object
subState		= 0;										// The current sub state of this object
beginWriting	= false;									// Should the object instantiate the writer?

// TEXT
textX			= 120;										// The X coordinate of where the text is going to be written
textY			= 320;										// The Y coordinate of where the text is going to be written
textNo			= 0;										// The current text number

// MISC
writer			= noone;									// The writer object
fading			= false;									// Is the object fading?
finalPanelX		= x;										// The X coordinate of the final panel
finalPanelY		= y + 138;									// The Y coordinate of the final panel
finalPanelTimer	= 0;										// The timer of the final panel
finalPanelShown	= false;									// Is the final panel shown?
music			= song_play(song_load("story"), 1, 0.91);	// Play the music

// CUTSCENE
scene = "cutscene_intro_0";									// Set the scene name
global.dxInterpreter.runScene(scene);						// Run the scene