/// @param filename
/// Loads the localization file and applies it to the game
function localization_load(){
	var fname = "data/" + argument[0] + ".json";	// File name with the extension being JSON
	var file = file_text_open_read(fname);			// Open the file
	var generated_json = "";						// Assign the generated string variable
	
	// Generate the string!
	while (!file_text_eof(file)) {
		generated_json += file_text_read_string(file);
		file_text_readln(file);
	}
	
	global.messages = json_decode(generated_json);
}