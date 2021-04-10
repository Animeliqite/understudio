function get_message( message_id ){
	if (ds_map_exists(global.messages, message_id))
		return ds_map_find_value(global.messages, message_id);
	else
		return "Error";
}