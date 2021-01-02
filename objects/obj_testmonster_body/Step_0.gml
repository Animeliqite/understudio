if (spared == true) {
    image_alpha = 0.5;
    
    image_index = 0;
    image_speed = 0;
    
    sprite_index = global.monster.hurtSprite[0];
    
    if (created < 6) {
        repeat (6) {
            instance_create(x, y, obj_spareeffect); 
            created++;
        }
    }
}

