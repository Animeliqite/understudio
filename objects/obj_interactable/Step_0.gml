if (collision_rectangle(x - 2, y - 2, x + sprite_width + 2, y + sprite_height + 2, obj_player, false, false)) {
    if (global.confirm) && (!global.cutscene) {
		create_dialogue(messages, font, baseColor, textEffect, textSound);
    }
}