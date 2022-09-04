/// @description Write text

if (!instance_exists(writer)) exit;
draw_rpgtext(textX, textY, writer.written, fnt_main, 1, global.mainFontWidth + 2, global.mainFontHeight, 1, 1, c_white);