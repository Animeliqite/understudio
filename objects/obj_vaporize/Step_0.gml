if (ready == true) {
	if (_y < 480) {
		repeat(4) {
			var _x = 0;
			
			repeat (640 / 2) {
				if (position_meeting(_x, _y, collision)) 
				instance_create_depth(_x, _y, depth_battle.enemy, obj_vaporize_dustpix);
				_x+=2;
			}
			_y+=2;
		}
	}
}