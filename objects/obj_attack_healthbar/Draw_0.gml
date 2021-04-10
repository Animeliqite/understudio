var damagefont = font_add_sprite_ext(spr_damagenum, "0123456789", 2, 2);

if (!miss) {
    if (show_hp > global.monster.monsterhp[obj_battlemanager.sel[1]]) {
        show_hp -= 1.5;
    }
    
    draw_set_halign(fa_center);
    draw_set_font(damagefont);
    draw_set_color(c_red);
    draw_text(xstart, y, string_hash_to_newline(obj_targetchoice.damage));
    
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    
    draw_healthbar(xstart - global.monster.body[obj_battlemanager.sel[1]].sprite_width + 28, ystart + 40 - 5, xstart + global.monster.body[obj_battlemanager.sel[1]].sprite_width - 28, ystart + 40 + 5, show_hp / global.monster.monsterhpmax[obj_battlemanager.sel[1]] * 100, c_gray, c_lime, c_lime, 0, true, true);

    if (alarm[0] < 0)
        alarm[0] = 40;
}
else {
    draw_sprite_ext(spr_miss, 0, xstart, ystart - 90, 1, 1, 0, c_silver, 1);
    
    if (alarm[0] < 0)
        alarm[0] = 50;
}

