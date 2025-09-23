// @description Draw Text using the new system

if (!drawText) exit;

// Update the visible characters in the arguments struct
text_args.visible = visible_chars;

// Call the new, powerful drawing function
draw_text_extended(
    x,
    y,
    text,     // The full text string, with all [commands] and `commands`
    text_args // The struct containing all our drawing parameters
);