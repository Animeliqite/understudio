var w = instance_create(60, (top ? 30 : 340), obj_writer);

for (var i = 0; i < array_length(messages); i++;) {
	w.messages[i] = messages[i];
}

for (var i = 0; i < array_length(formatList); i++;) {
	w.formatList[i] = formatList[i];
}

w.baseColor = baseColor;
w.font = font;
w.charWidth = charWidth;
w.charHeight = charHeight;
w.textEffect = textEffect;
w.textSpeed = textSpeed;
w.textSound = textSound;