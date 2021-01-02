if (!instance_exists(obj_dialogue_nonplayer)) {
    var dialogue = instance_create(0, 0, obj_dialogue_nonplayer);
    
    if (instance_exists(obj_typer)) {
        for (var i = 0; i < array_length_1d(text); i++;) {
            obj_typer.text[i] = text[i];
        }
        
        obj_typer.textFont = textFont;
        obj_typer.textColor = textColor;
        obj_typer.textEffect = textEffect;
    }
}

