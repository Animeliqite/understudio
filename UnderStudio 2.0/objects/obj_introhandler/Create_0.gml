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
cut				= c_create();								// Create the cutscene
c_pause(cut);												// Pause the cutscene

// FUNCTIONS
c_runText				= function (cut, text) {
	c_custom(cut, {
		text: text,
		init: function () {
			obj_introhandler.writer				= instance_create_depth(0, 0, 0, obj_textwriter);
			obj_introhandler.writer.text			= text + "`p3`";
			obj_introhandler.writer.voice		= [snd_alternatevoice];
			obj_introhandler.writer.textSpeed	= 1;
			obj_introhandler.writer.drawText		= false;
			obj_introhandler.writer.skippable	= false;
		},
		update: function () {
			if (instance_exists(obj_introhandler.writer)) {
				return (!obj_introhandler.writer.completed);
			} else return false;
		}
	});
}

c_fade					= function (cut, alphaTo, frames = 15) {
	c_custom(cut, {
		alphaTo: alphaTo,
		frames: frames,
		init: function () {
			execute_tween(obj_introhandler, "image_alpha", alphaTo, "linear", 15);
		},
		update: function () {
			if (frames > 0) {
				frames--;
				return true;
			} else return false;
		}
	});
}

// CUTSCENE
// Change it to however you want the object to execute, whether if it's some screen shaking or literally anything else.
c_runText(cut, "Long ago, two races#ruled over EARTH:#HUMANS and MONSTERS.");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "One day, war broke#out between the#two races.");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "After a long battle,#the humans were#victorious.");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "They sealed the monsters#underground with a magic#spell.");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "Many years later...");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "      MT. EBOTT#         201X");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "Legends say that those#who climb the mountain#never return.");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "`p6`");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "`p6`");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "`p6`");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "`p6`");
c_fade(cut, 1);
c_fade(cut, 0);
c_runText(cut, "`E1``p9``p9``p9``p9``p9``p8``E0`");

c_unpause(cut); // Unpause the cutscene