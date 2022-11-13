/// @description Initialize

// BUILT-IN
image_speed		= 0;			// Set the image speed to 0 so that the image index won't increment automatically
image_index		= 0;			// Set the image index to 0

// SYSTEM
timer			= 0;			// The main timer of this object
state			= 0;			// The current state of this object
subState		= 0;			// The current sub state of this object
beginWriting		= false;	// Should the object instantiate the writer?

// TEXT
textX			= 120;			// The X coordinate of where the text is going to be written
textY			= 320;			// The Y coordinate of where the text is going to be written
textNo			= 0;			// The current text number

// WRITER
runText					= function (text) {
	with (obj_introhandler) {
		writer				= instance_create_depth(0, 0, 0, obj_textwriter);
		writer.text			= text + "`p3`";
		writer.voice		= [snd_alternatevoice];
		writer.textSpeed	= 1;
		writer.drawText		= false;
		writer.skippable	= false;
	}
}

waitForNextPhase		= function () {
	c_next_editing_phase(id, "beginWriting", true);
}

// MISC
writer			= noone;				// The writer object
fading			= false;				// Is the object fading?
finalPanelX		= x;					// The X coordinate of the final panel
finalPanelY		= y + 138;				// The Y coordinate of the final panel
finalPanelTimer	= 0;					// The timer of the final panel
finalPanelShown	= false;				// Is the final panel shown?
music = song_play(song_load("story"), 1, 0.91);

// CUTSCENE
// Change it to however you want the object to execute, whether if it's some screen shaking or literally anything else.
c_reset_phase();
c_add_event(method_get_index(runText), ["Long ago, two races#ruled over EARTH:#HUMANS and MONSTERS."]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["One day, war broke#out between the#two races."]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["After a long battle,#the humans were#victorious."]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["They sealed the monsters#underground with a magic#spell."]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["Many years later..."]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["      MT. EBOTT#         201X"]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["Legends say that those#who climb the mountain#never return."]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["`p6`"]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["`p6`"]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["`p6`"]);
waitForNextPhase();				
c_add_event(method_get_index(runText), ["`p6`"]);
waitForNextPhase();
c_add_event(method_get_index(runText), ["`E1``p9``p9``p9``p9``p9``p8``E0`"]);
waitForNextPhase();
c_begin();