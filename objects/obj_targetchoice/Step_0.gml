if (x < obj_dborder.x) && (hspeed == 10) {
    if (input.confirm) {
        instance_create(global.monster.body[obj_battlecontroller.sel[1]].x, global.monster.body[obj_battlecontroller.sel[1]].y, obj_attack_knife);
        hspeed = 0;
        
        damage = round(damage);
    }
}
else if (x > obj_dborder.x - 10) {
    x = obj_dborder.x - 10;
    hspeed = 0;
    
    var inst = instance_create(global.monster.body[obj_battlecontroller.sel[1]].x, global.monster.body[obj_battlecontroller.sel[1]].y, obj_attack_healthbar);
    inst.miss = true;
}

if (x < obj_dborder.x - (sprite_get_width(spr_target) / 2) - 1) && (hspeed == 10) {
    damage++;
}
else if (x >= obj_dborder.x - (sprite_get_width(spr_target) / 2)) && (hspeed == 10) {
    if (damage > 0)
        damage--;
}

