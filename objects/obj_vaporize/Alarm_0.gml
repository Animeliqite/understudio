ready = true;
audio_play_sound(snd_dust, 10, false);

collision = instance_create(body.x, body.y, obj_vaporize_collision);
collision.sprite_index = monster.hurtSprite[obj_battlecontroller.sel[1]];
collision.image_xscale = body.image_xscale;
collision.image_yscale = body.image_yscale;

collision.image_speed = 0;
collision.image_index = 0;

collision.visible = false;