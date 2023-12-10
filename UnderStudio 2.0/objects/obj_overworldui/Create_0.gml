/// @description Initialize

state = -1;							// Current state
stateExecutedOnce = false;			// Is the state executed once?
prevState = state;					// The previous state
subState = 0;						// The sub state

dialogueText = "";					// The text the writer is going to show to the screen
dialogueFace = undefined;			// The face the dialogue box is going to show
dialogueFaceIndex = 0;				// The dialogue face image index
dialogueVoice = snd_defaultvoice;	// The voice that's going to play
dialogueCompleted = false;			// Is the dialogue completed?
dialogueFont = fnt_main;			// The current dialogue font
dialogueWriter = noone;				// The dialogue writer
dialogueIsOnTop = undefined;		// Is the dialogue box on top?
dialogueAlignY = 0;					// Dialogue align in the Y axis