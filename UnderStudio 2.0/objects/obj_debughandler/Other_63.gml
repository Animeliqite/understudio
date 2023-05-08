/// @description Get Integer Check

// Check if the game is in debug mode
if (DEBUG) {
	var _id = ds_map_find_value(async_load, "id");
	if (_id == roomGoToDialog) {
		if ds_map_find_value(async_load, "status") {
			room_goto(ds_map_find_value(async_load, "value"));
			if(dx_is_active()) dx_endscene();
			game_set_speed(prevGameSpeed, gamespeed_fps);
		}
	}
}