instance_destroy();
with (global.monster) {
    event_user(1);
}

global.monster.body[obj_battlecontroller.sel[1]].sprite_index = global.monster.normalSprite[obj_battlecontroller.sel[1]];

