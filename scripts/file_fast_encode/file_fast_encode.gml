/// @description file_fast_encode(input_file, output_file);
/// @function file_fast_encode
/// @param0 input_file
/// @param1 output_file
function file_fast_encode(argument0, argument1) {

	// Script by Andrius Valkiunas http://www.existical.com/
	// Part of the "Fast Crypt Ultra" bundle at https://marketplace.yoyogames.com/assets/6057/fast-crypt
	// Version 1.4 - 22nd September 2019

	/*
	****************************************************************************************************
	*** PLEASE NOTE, THIS IS A VERY SIMPLE AND FAST ENCODING INTENDED TO OBFUSCATE AND HIDE YOUR     ***
	*** GAME DATA, AND IT DOES NOT OFFER SECURE PROTECTION AGAINST PROFESSIONAL HACKERS/CRACKERS :)  ***
	*** FOR BEST SECURITY PLEASE USE SCRIPT 'file_fast_crypt_ultra' or 'file_fast_crypt_ultra_zlib'  ***
	*** AS THEY BOTH USE SECURE ENCRYPTION WITH A SECRET KEY AND ALSO COMPRESSION (LAST SCRIPT ONLY) ***
	****************************************************************************************************

	This is a very simple file encoding script which can encode/decode any file by shifting each byte value by 128 bits. 

	Same script is used to Encode and Decode files.

	You can use same filename as input and output parameters.

	******** USAGE EXAMPLE: *********************************************

	* Encoding file to a different file:
	file_fast_encode("game_level_01.ini", "game_level_01.lev");

	* Decoding encoded file to a different file:
	file_fast_encode("game_level_01.lev", "game_level_01.ini");

	* Encoding file to the same file:
	file_fast_encode("user_progress.dat", "user_progress.dat");

	* Decoding encoded file to the same file (same as above):
	file_fast_encode("user_progress.dat", "user_progress.dat");

	*********************************************************************

	If you like this script, please consider making a donation to the author using PayPal to valkiunas@gmail.com.

	*/

	var _data, _filename_in, _filename_out, _pos, _len;

	_filename_in = argument0; // File name of the input file to read data
	_filename_out = argument1; // File name of the output processed file to save data. Can be the same as input file or different new file.
	_pos = 0; // Initial 'seek' position in the buffer

	var _file_buffer = buffer_load(_filename_in); // Reading input file into the buffer
	_len = buffer_get_size(_file_buffer);  // Getting lenght of the buffer (file size)
	buffer_seek(_file_buffer, buffer_seek_start, _pos); // Setting 'seek' at the initial position

	while(_pos != _len) // Processing each byte in the buffer step by step until the end of the buffer
	{
		_data = (buffer_read(_file_buffer, buffer_u8) + 128) mod 256; // Reading current byte and encoding it

		buffer_seek(_file_buffer, buffer_seek_start, _pos); // Setting current 'seek' position in the buffer
		buffer_write(_file_buffer, buffer_u8, _data); // Writing processed byte to the buffer

		_pos = buffer_tell(_file_buffer);	// Getting current 'seek' position in the buffer

		//show_debug_message(string(pos/len * 100) +"%");
	}

	buffer_save(_file_buffer, _filename_out); // Saving processed buffer into the output file
	buffer_delete(_file_buffer); // Removing buffer from memory

	//show_debug_message("Fast File Encryption Completed");
	return 1;


}
