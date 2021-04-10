if (collision_rectangle(x - 2, y - 2, x + sprite_width + 2, y + sprite_height + 2, obj_player, false, false)) {
    if (global.confirm) && (!global.cutscene) && (interactable) {
		create_dialogue(messages, formatList, font, baseColor, textEffect, textSound);
		interact_amount++;
		alarm[0] = 1; //On Dialogue Start
    }
}