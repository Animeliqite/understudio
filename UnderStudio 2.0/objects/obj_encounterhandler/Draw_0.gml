/// @description Draw necessary things

var cam = obj_camerahandler;
var obj = encounterObject;
if (state == 1 || state == 2)
	draw_sprite_ext(spr_pixel, 0, cam.x, cam.y, cam.camWidth, cam.camHeight, 0, c_black, 1);
if (state == 1)
	draw_sprite_ext(obj.sprite_index, obj.image_index, obj.x, obj.y, obj.image_xscale, obj.image_yscale, obj.image_angle, obj.image_blend, obj.image_alpha);
if (state == 1 || state == 2)
	draw_sprite_ext(spr_heartsmall, 0, cam.x + heartX - 4, cam.y + heartY, 1, 1, 0, c_white, encounterHeartShow);