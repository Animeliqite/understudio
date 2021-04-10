// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function localization_load( langname ){
	var fileDir = "data/game-" + langname + ".lang";
	var jsonDir = "data/game.json";
	
	var jsonFile = file_text_open_read(jsonDir);
	var newFile = file_text_open_read(fileDir);
	var generated_json = "";
	
	while (!file_text_eof(jsonFile)) {
		generated_json += file_text_read_string(jsonFile);
		file_text_readln(jsonFile);
	}
	
	var json = json_parse(generated_json);
	var messages = variable_struct_get_names(json);
	for (var n = 0; n < array_length(messages); n++;) {
		ds_map_replace(global.messages, messages[n], file_text_read_string(newFile));
		file_text_readln(newFile);
		
		show_debug_message(ds_map_find_value(global.messages, messages[n]));
		if (n >= array_length(messages)) {
			file_text_close(jsonFile);
			file_text_close(newFile);
		}
	}
}