if (spared == true) {
    image_alpha = 0.5;
    
    image_index = 0;
    image_speed = 0;
    
    sprite_index = global.monster.hurtSprite[0];
    
    if (created < 12) {
        repeat (12) {
            instance_create(x, y, obj_dustcloud); 
            created++;
        }
    }
}

