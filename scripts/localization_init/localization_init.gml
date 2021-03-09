function localization_init( filename ){
	var file = file_text_open_read(working_directory + filename);
	var generated_json = "";
	while (!file_text_eof(file)) {
		generated_json += file_text_read_string(file);
		file_text_readln(file);
	}
	
	var json = json_parse(generated_json);
	var messages = variable_struct_get_names(json);
	for (var n = 0; n < array_length(messages); n++;) {
		ds_map_add(global.messages, messages[n], variable_struct_get(json, messages[n]));
		show_debug_message(ds_map_find_value(global.messages, messages[n]));
	}
}