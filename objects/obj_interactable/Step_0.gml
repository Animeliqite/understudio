if (collision_rectangle(x - 2, y - 2, x + sprite_width + 2, y + sprite_height + 2, obj_player, false, false)) {
    if (global.confirm) {
        keyboard_clear(vk_enter);
        keyboard_clear(ord("Z"));
        
        global.cutscene = true;
        
        if (!instance_exists(obj_dialogue)) {
            var dialogue = instance_create(0, 0, obj_dialogue);
            
            if (instance_exists(obj_typer)) {
                for (var i = 0; i < array_length_1d(text); i++;) {
                    obj_typer.text[i] = text[i];
                }
                
                obj_typer.textFont = textFont;
                obj_typer.textColor = textColor;
                obj_typer.textEffect = textEffect;
            }
        }
    }
}

