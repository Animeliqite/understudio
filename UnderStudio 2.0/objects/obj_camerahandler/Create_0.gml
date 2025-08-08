/// @description Initialize

event_user(0);
cam = camera_create_view(x, y, camWidth / camScaleX, camHeight / camScaleY, camAngle, noone, -1, -1, camWidth / camScaleX / 2, camHeight / camScaleY / 2);
camera_initialized = false;

camMoveTo = function (target, duration, tween = "linear", delay = 0) {
	execute_tween(id,"posX",target.x-(camWidth/camScaleX/2),tween,duration,false,delay);
	execute_tween(id,"posY",target.y-(camHeight/camScaleY/2),tween,duration,false,delay);
	currTarget = noone;
}

camMoveToPos = function (_x, _y, duration, tween = "linear", delay = 0) {
	execute_tween(id,"posX",_x-(camWidth/camScaleX/2),tween,duration,false,delay);
	execute_tween(id,"posY",_y-(camHeight/camScaleY/2),tween,duration,false,delay);
	currTarget = noone;
}

setCamPos = function (_type, _value) {
	if (_type == "x") posX = median(0, _value-(camWidth/camScaleX/2), room_width-camWidth/camScaleX);
	else if (_type == "y") posY = median(0, _value-(camHeight/camScaleY/2), room_height-camHeight/camScaleY);
}

camShake = function(_x, _y, _rand_x, _rand_y, _dec_x, _dec_y) {
	shake_x = _x;
	shake_y = _y;
	shake_random_x = _rand_x;
	shake_random_y = _rand_y;
	shake_decrease_x = _dec_x;
	shake_decrease_y = _dec_y;
    
	shake_curr_x = _x;
	shake_curr_y = _y;
	shake_dir_x = 1;
	shake_dir_y = 1;
};