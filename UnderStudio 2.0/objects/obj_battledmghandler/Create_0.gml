/// @description Initialize

dmgAmount = global.playerATWeapon + floor(median(10, global.playerHP._max, 90) - 10) / 10;
dmgFont = font_add_sprite_ext(spr_battle_dmg, "0123456789", false, 2);