/// @description Draw the UI

draw_healthbar(x - barWidth / 2, y - barHeight / 2 + barYOffset, x + barWidth / 2, y + barHeight / 2 + barYOffset, ((hpOld - dmgAmount) / hpOld) * 100, barBackColor, barRemainingColor, barRemainingColor, 0, true, false);

draw_set_font(dmgFont);
draw_set_color(c_red);
draw_set_halign(fa_center);

draw_text(x + dmgX, y + dmgY, string(dmgAmount));

draw_set_halign(fa_left);