/// @description Pick up colors
///////////////////////////////////////////////////////////////////////
var buff = buffer_getpixel_begin(application_surface);//create/update buffer with surface
 var c = buffer_getpixel(buff,mouse_x,mouse_y,W,H);//get pixel RGB from mouse coordinates
 var r = buffer_getpixel_r(buff,mouse_x,mouse_y,W,H);//get red value
 var g = buffer_getpixel_g(buff,mouse_x,mouse_y,W,H);//get green value
 var b = buffer_getpixel_b(buff,mouse_x,mouse_y,W,H);//get blue value
buffer_delete(buff);//remove memory
///////////////////////////////////////////////////////////////////////

draw_rectangle(0,0,120,70,0)
draw_text_color(4,0,"C: "+string(c),c_ltgray,c_ltgray,c_ltgray,c_ltgray,1)
draw_text_color(4,12,"R: "+string(r),c_red,c_red,c_red,c_red,1)
draw_text_color(4,24,"G: "+string(g),c_green,c_green,c_green,c_green,1)
draw_text_color(4,36,"B: "+string(b),c_blue,c_blue,c_blue,c_blue,1)
draw_text_color(4,48,"FPS: "+string(fps_real),c_dkgray,c_dkgray,c_dkgray,c_dkgray,1)