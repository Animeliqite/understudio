/// @description At Menu Choosing

switch (bt_getmenu()) {
	case 999: // FIGHT
		switch (bt_getstatesel()) {
			case 2:
				var damage = bt_getmonsterdamage();
				var healthBar = instance_create_depth(x, y - 100, depth_battle.ui, obj_attackhealthbar);
				healthBar.damage = damage;
				
				scr_shake(id, 18, 0);
				audio_play_sound(snd_damage_dog, 0, false);
		}
		break;
	case 4:
		audio_play_sound(snd_dust, 0, false);
		image_alpha = 0.5;
		image_speed = 0;
		image_index = 0;
		repeat (12) {
			instance_create(x, y, obj_dustcloud);
		}
		break;
}