draw_self();

if (drawSmoke) {
    draw_sprite(spr_bpants_smoke, image_index, x - 60, y - 10);
}
if (drawHands) {
    draw_sprite(spr_bpants_hands, image_index, random_range(xstart + 0.25, xstart - 0.25) - 35, random_range(ystart + 0.25, ystart - 0.25) + 23);
}

event_inherited();

