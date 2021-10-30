instance_destroy();
with (global.monster) {
    event_user(1);
}

global.monster.body[obj_battlemanager.sel[1]].sprite_index = global.monster.normalSprite[obj_battlemanager.sel[1]];