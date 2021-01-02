draw_set_color(c_white);
draw_set_font(fnt_dialogue);

scr_shop_draw_infobox(menuMiniY, "SOLD OUT");

draw_box(0, 120, 319, 239);
if (menu == 0) {
    draw_box(210, 120, 319, 239);
    
    if (global.genocide > -1) {
        draw_text(240, 130, string_hash_to_newline("Take"));
        draw_text(240, 150, string_hash_to_newline("Steal"));
        draw_text(240, 170, string_hash_to_newline("Read"));
    }
    else {
        draw_text(240, 130, string_hash_to_newline("Buy"));
        draw_text(240, 150, string_hash_to_newline("Sell"));
        draw_text(240, 170, string_hash_to_newline("Talk"));
    }
    
    draw_sprite(spr_heartsmall, 0, 225, 134 + (menuSel[0] * 20));
    
    draw_text(240, 190, string_hash_to_newline("Exit"));
}
else if (menu == 2) {
    draw_box(210, 120, 319, 239);
    
    scr_shop_draw_talktitle(0, talkOptionNew[0], talkOption[0]);
    
    scr_shop_draw_talktitle(1, talkOptionNew[1], talkOption[1]);
    
    scr_shop_draw_talktitle(2, talkOptionNew[2], talkOption[2]);
    
    scr_shop_draw_talktitle(3, talkOptionNew[3], talkOption[3]);
    
    draw_text(30, 210, string_hash_to_newline("Exit"));
    
    draw_sprite(spr_heartsmall, 0, 15, 134 + (menuSel[1] * 20));
}

