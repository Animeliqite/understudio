if (!instance_exists(obj_typer))
    create_text(x + 5, y - (sprite_get_height(sprite[text_current])) + 48, "SPEECH", c_black, text[text_current], true);

if (obj_typer.writing == false) && (global.confirm) {
    if (text_current < text_end)
        text_current++;
    else {
        instance_destroy();
        battle_setstate(-2);
    }
}

