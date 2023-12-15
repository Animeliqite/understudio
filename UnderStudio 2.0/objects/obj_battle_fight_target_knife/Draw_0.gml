/// @description Draw the UI

draw_self();

if (!targetFade)
	draw_sprite_ext(spr_battle_fight_targetchoice, current_time / 250, barX, barY, 1, 1, 0, c_white, 1);