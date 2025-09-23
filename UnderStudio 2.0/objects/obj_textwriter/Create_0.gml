// @description Initialize Typewriter

// --- Core Typewriter State ---
text			= "";						// The text that the writer is going to write.
visible_chars	= 0;						// The number of characters currently visible.
textSpeed		= 1;						// The speed of the writing process (frames per character).
holdTimer		= 0;						// The timer that the writer is going to wait before adding a letter.
voice			= [snd_defaultvoice];		// The sound that will play when the writer writes a letter.

// --- Control & Status Flags ---
drawText		= true;						// Decides whether to draw the text on the screen.
skipText		= false;					// Decides whether to skip the writing process.
skippable		= true;						// Is the text skippable?
completed		= false;					// Is the writer finished?

// --- Formatting & Parsing ---
formatText		= true;						// Should the writer auto-format the text with pauses?
raw_text        = "";                       // The original, un-formatted text.
parser_pos      = 0;                        // The internal position for parsing commands in the text.

// --- Arguments for the new drawing function ---
text_args = {
    halign:         fa_left,
    valign:         fa_top,
    size:           1,
    visible:        0, // This will be updated every frame
    font:           fnt_main,
    alpha:          1,
    color:          c_white,
    effect:         "none",
	letter_width:   -1,
	letter_height:  -1,
    letter_spacing: 1,
    line_spacing:   1.2,
    line_break:     -1, // Default to no word wrap. Set to a pixel width to enable.
};

// A function to easily set up the typewriter
function set_text(_text) {
    raw_text = _text;
    text = formatText ? format_text_with_pauses(raw_text) : raw_text;
    
    visible_chars = 0;
    parser_pos = 0;
    completed = false;
    skipText = false;
    holdTimer = max(0, textSpeed);
}