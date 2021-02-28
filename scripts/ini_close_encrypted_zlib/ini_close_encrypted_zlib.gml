/// @description ini_close_encrypted_zlib(output_file, encryption_key_string);
/// @function ini_close_encrypted_zlib
/// @param0 output_file
/// @param1 encryption_key_string
function ini_close_encrypted_zlib(argument0, argument1) {

	// Script by Andrius Valkiunas http://www.existical.com/
	// Part of the "Fast Crypt Ultra" bundle at https://marketplace.yoyogames.com/assets/6057/fast-crypt
	// Version 1.4 - 22nd September 2019

	/*
	******** README *****************************************************

	This script is a modified version of the 'file_fast_crypt_ultra_zlib' script.
	I have left here only the encryption code.

	The purpose of this script is to compress & encrypt .ini file in the computer's memory and save already encrypted file to the disk without creating the unencrypted copy.

	*********************************************************************

	If you like this script, please consider making a donation to the author using PayPal to valkiunas@gmail.com.

	*/

	var _data, _filename_out, _pos, _len, _xor_shift, _bit_shift, _shift_direction, _enc_key, _key_hash, _key_hash2, _key_pos, _key_len;

	_filename_out = argument0; // File name of the output processed file to save data. Can be the same as input file or different new file.
	_key_pos = 0; // Current position of encryptor key byte
	_pos = 0; // Initial 'seek' position in the buffer
	_bit_shift = 128; // Initial bit shift value
	_xor_shift = 1; // Initial xor shift value

	_enc_key = argument1;

	_key_hash = md5_string_unicode(_enc_key)+sha1_string_unicode(_enc_key)+md5_string_utf8(_enc_key)+sha1_string_utf8(_enc_key); // Getting first 72 byte (576 bit) long multi-hash string to use as encryption key
	_key_hash2 = md5_string_unicode(_key_hash)+sha1_string_unicode(_key_hash)+md5_string_utf8(_key_hash)+sha1_string_utf8(_key_hash); // Getting additional 72 byte (576 bit) long multi-hash string based on previous hash string
	_key_hash = _key_hash + _key_hash2; // Creating united unique 144 byte (1152 bit) hash key for encrypting data
	_key_len = string_length(_key_hash) div 2; // Key length in bytes

	// Setting bit shift direction (increments or decrements)
	_shift_direction = 1;

	// Creating an array for each hash key byte {{{
	var _key_arr;
	for (var _i=0; _i<_key_len; _i++)
	{
	    _key_arr[_i] = hex_to_dec_fast(string_copy(_key_hash, (_i*2)+1, 2)); // Converting hexadecimal parts of hash key into decimal numbers which are stored in array
	}
	// Creating an array for each hash key byte }}}

	_xor_shift = _xor_shift mod 10; // Initial xor_shift value will depend on the key hash sum module of 10

	// Getting DATA from virtual .ini to the buffer {{{
	var _input_buffer = buffer_create(1, buffer_grow, 1); // Creating buffer for ini file data
	buffer_seek(_input_buffer, buffer_seek_start, 0); // Setting 'seek' at the initial position
	var _virtual_ini_string = ini_close(); // Sending virtual ini file data to the string and closing ini file
	buffer_write(_input_buffer, buffer_text, _virtual_ini_string); // Writing virtual ini data to the buffer
	// Getting DATA from virtual .ini to the buffer }}}

	var _input_buffer_size = buffer_get_size(_input_buffer); // Retrieving input data buffer size	
	if(_input_buffer_size == 0) // If the buffer size is zero, return with an error
	{
		return 0; // Script returns 0 as unsuccessfull operation
	}
	
	var _data_buffer = buffer_compress(_input_buffer, 0, _input_buffer_size); // Compressing input_buffer to data_buffer
	buffer_delete(_input_buffer); // Deleting 'input_buffer' with uncompressed data from RAM to avoid memory leaks

	_len = buffer_get_size(_data_buffer); // Getting lenght of the buffer (file size)
	buffer_seek(_data_buffer, buffer_seek_start, _pos); // Setting 'seek' at the initial position

	while(_pos != _len) // Processing each byte in the buffer step by step until the end of the buffer
	{
		_data = ((((buffer_read(_data_buffer, buffer_u8) + _bit_shift + _key_arr[_key_pos]) mod 256) ^ _xor_shift) ^ _key_arr[_key_pos]); // Reading current byte and encrypting it	
	
		// Xor shift calculations {{{
		_xor_shift += 1;
	
		// Every 5000 bytes encryption key is changed
		if (_xor_shift > 5000)
		{ 
			_xor_shift = 1;
		
			// Modifying encryption key	{{{
			_key_hash = md5_string_unicode(_key_hash2)+sha1_string_unicode(_key_hash2)+md5_string_utf8(_key_hash2)+sha1_string_utf8(_key_hash2); // Getting first 72 byte (576 bit) long multi-hash string to use as encryption key
			_key_hash2 = md5_string_unicode(_key_hash)+sha1_string_unicode(_key_hash)+md5_string_utf8(_key_hash)+sha1_string_utf8(_key_hash); // Getting additional 72 byte (576 bit) long multi-hash string based on previous hash string
			_key_hash = _key_hash + _key_hash2; // Creating united unique 144 byte (1152 bit) hash key for encrypting data
		
			for (var _i=0; _i<_key_len; _i++)
			{
				_key_arr[_i] = hex_to_dec_fast(string_copy(_key_hash, (_i*2)+1, 2)); // Converting hexadecimal parts of hash key into decimal numbers which are stored in array
			}
			// Modifying encryption key	}}}
		}
		// Xor shift calculations }}}
	
		// Bit shift calculations {{{
		_bit_shift += _shift_direction * (_key_arr[(_key_len-1)-_key_pos] mod 2);
		if (_bit_shift > 255) { _bit_shift = 1;}
		else if (_bit_shift < 1) { _bit_shift = 255;}
		// Bit shift calculations }}}
	
		// Current Encryption Key byte position {{{
		_key_pos += 1;
		if (_key_pos > (_key_len-1)) {_key_pos = 0; }
		// Current Encryption Key byte position }}}
	
		buffer_seek(_data_buffer, buffer_seek_start, _pos); // Setting current 'seek' position in the buffer
		buffer_write(_data_buffer, buffer_u8, _data); // Writing processed byte to the buffer
		_pos = buffer_tell(_data_buffer); // Getting current 'seek' position in the buffer
	}

	buffer_save(_data_buffer, _filename_out); // Writing compressed & encrypted 'data_buffer' into the output file
	buffer_delete(_data_buffer); // Removing 'data_buffer' buffer from RAM to avoid memory leaks

	return 1; // Script returns 1 as successfull operation


}
