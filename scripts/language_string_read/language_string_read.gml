function language_string_read(language_id, key_id){
	return ds_map_find_value(language_id, string(language_id) + "_String_" + string(key_id));
}