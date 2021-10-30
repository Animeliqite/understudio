var damageFont = font_add_sprite_ext(spr_damagenum, "0123456789", 2, 2);
if (damage > 0) {
	draw_text_style(string(damage), xstart, y, damageFont, c_red, fa_center, fa_top);
	draw_healthbar(xstart - (barWidth / 2), ystart - 6 + 40, xstart + (barWidth / 2), ystart + 6 + 40, (newHP / obj_battlemanager.monsterHPMax[bt_getcurrent_monster()]) * 100, barColor[0], barColor[1], barColor[1], 0, true, false);
}
else
	draw_sprite_ext(spr_miss, 0, xstart, ystart - 45, 1, 1, 0, c_silver, 1);

if (alarm[0] < 0)
	alarm[0] = barDuration;