if (!miss) {
    audio_play_sound(global.monster.hurtsound[obj_battlemanager.sel[1]], 10, false);
    scr_shake(global.monster.body[obj_battlemanager.sel[1]], 18, 0);
    global.monster.monsterhp[obj_battlemanager.sel[1]] -= obj_targetchoice.damage;
    global.monster.body[obj_battlemanager.sel[1]].sprite_index = global.monster.hurtSprite[obj_battlemanager.sel[1]];
}

