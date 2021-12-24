// This script reads the contents of a .json file and returns the decoded content of it
function json_decode_from_filename(fname) {
	var file = file_text_open_read(global.localizationFilePath + fname + ".json");
	var content = "";
	
	while (!file_text_eof(file)) {
		content += file_text_read_string(file);
		file_text_readln(file);
	}
	return json_parse(content);
}

// This script loads the language file from what the global variable equals to
function language_util() {
	var fname;
	switch (global.language) {
		case "en":
			fname = "game";
			break;
	}
	return json_decode_from_filename(fname);
}

// This script gets a raw value of a struct name from a .json file
function language_raw(key, languageData) {
	return variable_struct_get(!is_undefined(languageData) ? languageData : global.languageData, key);
}