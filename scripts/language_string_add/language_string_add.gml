function language_string_add(language_id, key_id, str){
	ds_map_add(language_id, string(language_id) + "_String_" + string(key_id), str);
}