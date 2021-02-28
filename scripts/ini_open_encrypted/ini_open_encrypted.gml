/// @description ini_open_encrypted(input_file, encryption_key_string);
/// @function ini_open_encrypted
/// @param0 input_file
/// @param1 encryption_key_string
function ini_open_encrypted(argument0, argument1) {

	// Script by Andrius Valkiunas http://www.existical.com/
	// Part of the "Fast Crypt Ultra" bundle at https://marketplace.yoyogames.com/assets/6057/fast-crypt
	// Version 1.4 - 22nd September 2019

	/*
	******** README *****************************************************

	This script is a modified version of the 'file_fast_crypt_ultra' script.
	I have left here only the decryption code.

	The purpose of this script is to decrypt encrypted ini file directly to the memory without creating decrypted copy on the disk.


	IMPORTANT INFORMATION TO REMEMBER:
	1) If you are doing only Reading from the encrypted .ini file, please use 'ini_close' once you are finished.
	2) If you are Writing or both Reading & Writing to/from .ini file, please use 'ini_close_encrypted' once you are finished.
	Script 'ini_close_encrypted' will encrypt all data in the computer's memory and will save to disk already encrypted file without creating the unencrypted copy.

	******** USAGE EXAMPLE: *********************************************

	* Only READING from encrypted (non-compressed) savedata.ini:

	ini_open_encrypted("savedata.ini","SomeEncryptionKey"); // Decrypt and open .ini
	global.player_hiscore = ini_read_string("player", "name", "Noname");
	global.player_hiscore = ini_read_real("player", "hiscore", 0);
	ini_close(); // Close .ini without writing to it


	* READING & WRITING from/to encrypted (non-compressed) savedata.ini:

	ini_open_encrypted("savedata.ini","SomeEncryptionKey"); // Decrypt and open .ini
	ini_write_string("options", "sound", string(global.options_sound));
	ini_write_string("options", "music", string(global.options_music));
	ini_write_string("player", "name", global.player_name);
	ini_write_string("player", "hiscore", string(global.player_hiscore));
	ini_close_encrypted("savedata.ini","SomeEncryptionKey"); // Encrypt and save .ini

	*********************************************************************

	If you like this script, please consider making a donation to the author using PayPal to valkiunas@gmail.com.

	*/

	var _data, _filename_in, _pos, _len, _xor_shift, _bit_shift, _shift_direction, _enc_key, _key_hash, _key_hash2, _key_pos, _key_len;

	_filename_in = argument0; // File name of the input file to read data

	if file_exists(_filename_in)
	{
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
		_shift_direction = -1;

		// Creating an array for each hash key byte {{{
		var _key_arr;
		for (var _i=0; _i<_key_len; _i++)
		{
		    _key_arr[_i] = hex_to_dec_fast(string_copy(_key_hash, (_i*2)+1, 2)); // Converting hexadecimal parts of hash key into decimal numbers which are stored in array
		}
		// Creating an array for each hash key byte }}}

		_xor_shift = _xor_shift mod 10; // Initial xor_shift value will depend on the key hash sum module of 10

		var _file_buffer = buffer_load(_filename_in); // Reading input file into the buffer
		_len = buffer_get_size(_file_buffer); // Getting lenght of the buffer (file size)
		buffer_seek(_file_buffer, buffer_seek_start, _pos); // Setting 'seek' at the initial position

		while(_pos != _len) // Processing each byte in the buffer step by step until the end of the buffer
		{
			_data = (((buffer_read(_file_buffer, buffer_u8)  ^ _xor_shift) ^ _key_arr[_key_pos]) + _bit_shift - _key_arr[_key_pos]) mod 256; // Reading current byte and encrypting it	
	
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
			if (_key_pos > (_key_len-1)) { _key_pos = 0; }
			// Current Encryption Key byte position }}}
	
			buffer_seek(_file_buffer, buffer_seek_start, _pos); // Setting current 'seek' position in the buffer
			buffer_write(_file_buffer, buffer_u8, _data); // Writing processed byte to the buffer
			_pos = buffer_tell(_file_buffer); // Getting current 'seek' position in the buffer
		}
	
		buffer_seek(_file_buffer, buffer_seek_start, 0); // Setting 'seek' at the initial position
		var _string_from_buffer = buffer_read(_file_buffer, buffer_string); // Writing final decrypted & decompressed 'output_buffer' data to string
		ini_open_from_string(_string_from_buffer);
		buffer_delete(_file_buffer); // Removing buffer from memory
	}
	else
	{
		ini_open_from_string("");
	}

	return 1;


}
