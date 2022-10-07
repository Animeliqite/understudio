/// 
/// MIT License
/// 
/// Copyright (c) 2022 Rupitian
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
/// 

#macro DIANNEX_FORMAT_VERSION 4
#macro DIANNEX_FORMAT_VERSION_TRANSLATION 0

function DiannexData() constructor
{
	scenes = {};
	functions = undefined;
	definitions = {};
	strings = [];
	text = [];
	originalText = undefined;
	instructions = undefined;
	flagsInitialized = false;
	defaultInterpreter = new DiannexInterpreter(self);
	currentCacheID = -1	;
	
	setFlagHandler = function(name, value)
	{
		throw "Missing set flag handler. Set variable 'setFlagHandler' on DiannexData instance.";
	};
	getFlagHandler = function(name)
	{
		throw "Missing get flag handler. Set variable 'getFlagHandler' on DiannexData instance.";
	};
	
	/// @desc Loads all data from a Diannex binary file. Will throw exception/error if unsuccessful.
	static loadFromFile = function(fname)
	{
		var buff = buffer_load(fname);
		
		// Header magic
		if (buffer_read(buff, buffer_u8) != ord("D"))
			throw "Not a Diannex binary file: invalid header";
		if (buffer_read(buff, buffer_u8) != ord("N"))
			throw "Not a Diannex binary file: invalid header";
		if (buffer_read(buff, buffer_u8) != ord("X"))
			throw "Not a Diannex binary file: invalid header";
			
		// Check format version
		if (buffer_read(buff, buffer_u8) != DIANNEX_FORMAT_VERSION)
			throw "Diannex binary format version is not compatible with this interpreter";
			
		// Read flags
		var flags = buffer_read(buff, buffer_u8);
		var flagCompressed = (flags & 1) != 0;
		var flagInternalTranslation = (flags & (1 << 1)) != 0;
		
		// Skip uncompressed data size, as GameMaker does not need it
		buffer_read(buff, buffer_u32);
		
		// Decompress data if that flag is enabled
		if (flagCompressed)
		{
			// Compressed data size
			var size = buffer_read(buff, buffer_u32);
			
			// Copy compressed data to its own temporary buffer
			var tempBuff = buffer_create(size, buffer_fixed, 1);
			buffer_copy(buff, buffer_tell(buff), size, tempBuff, 0);
			
			// Delete main buffer as it is no longer needed
			buffer_delete(buff);
			
			// Decompress temporary buffer into main buffer variable, and delete temporary buffer
			buff = buffer_decompress(tempBuff);
			buffer_delete(tempBuff);
			
			if (!buffer_exists(buff))
				throw "Diannex binary decompression failed";
		}
		
		// Skip scene data
		var sceneSize = buffer_read(buff, buffer_u32);
		var sceneOffset = buffer_tell(buff);
		buffer_seek(buff, buffer_seek_relative, sceneSize);
	
		// Skip function data
		var funcSize = buffer_read(buff, buffer_u32);
		var funcOffset = buffer_tell(buff);
		buffer_seek(buff, buffer_seek_relative, funcSize);
	
		// Skip definition data
		var defSize = buffer_read(buff, buffer_u32);
		var defOffset = buffer_tell(buff);
		buffer_seek(buff, buffer_seek_relative, defSize);
		
		// Copy instruction data into its own buffer for later use
		var instructionLength = buffer_read(buff, buffer_u32);
		instructions = buffer_create(instructionLength, buffer_fixed, 1);
		buffer_copy(buff, buffer_tell(buff), instructionLength, instructions, 0);
		buffer_seek(buff, buffer_seek_relative, instructionLength);
		
		// Read string table
		buffer_read(buff, buffer_u32); // Ignore size; we're going to read this now
		var stringCount = buffer_read(buff, buffer_u32);
		var _strings = array_create(stringCount);
		var i = 0;
		repeat (stringCount)
		    _strings[i++] = buffer_read(buff, buffer_string);
		strings = _strings;
		
		if (flagInternalTranslation)
		{
			// Read internal translation table
			buffer_read(buff, buffer_u32); // Ignore size; we're going to read this now
			var textCount = buffer_read(buff, buffer_u32); 
			var _text = array_create(textCount);
			var i = 0;
			repeat (textCount)
			    _text[i++] = buffer_read(buff, buffer_string);
			text = _text;
		}
		
		// Parse external function list
		// By parse I mean ignore because for now, this will be purely debug info
		// In some other interpreters this is used to link functions, though
		buffer_read(buff, buffer_u32); // Ignore size; we're going to read this now
		var externalFunctionCount = buffer_read(buff, buffer_u32);
		buffer_seek(buff, buffer_seek_relative, externalFunctionCount * 4);
		
		// Parse scene data
		buffer_seek(buff, buffer_seek_start, sceneOffset);
		var sceneCount = buffer_read(buff, buffer_u32);
		repeat (sceneCount)
		{
			var sceneName = _strings[buffer_read(buff, buffer_u32)];
			scenes[$ sceneName] = new DiannexScene(buff, sceneName);
		}
		
		// Parse function data
		buffer_seek(buff, buffer_seek_start, funcOffset);
		var funcCount = buffer_read(buff, buffer_u32);
		functions = array_create(funcCount);
		var i = 0;
		repeat (funcCount)
			functions[i++] = new DiannexFunction(buff, _strings);
		
		// Parse definition data
		buffer_seek(buff, buffer_seek_start, defOffset);
		var defCount = buffer_read(buff, buffer_u32);
		repeat (defCount)
		{
			var defName = _strings[buffer_read(buff, buffer_u32)];
			definitions[$ defName] = new DiannexDefinition(buff);
		}
		 
		// Discard main buffer
		buffer_delete(buff);
		
		// Increment cache ID to account for new data
		currentCacheID++;
	};
	
	static unload = function()
	{
		if (!is_undefined(defaultInterpreter))
		{
			defaultInterpreter.unload();
			defaultInterpreter = undefined;
		}
		if (!is_undefined(instructions) && buffer_exists(instructions))
		{
			buffer_delete(instructions);
			instructions = undefined;
		}
	};
	
	static loadBinaryTranslationFile = function(fname)
	{
		if (is_undefined(originalText))
		{
			// Copy text into original text array, so it can potentially be reloaded later
			var length = array_length(text);
			originalText = array_create(length);
			array_copy(originalText, 0, text, 0, length);
		}
		
		var buff = buffer_load(fname);
		
		// Header magic
		if (buffer_read(buff, buffer_u8) != ord("D"))
			throw "Not a Diannex binary translation file: invalid header";
		if (buffer_read(buff, buffer_u8) != ord("X"))
			throw "Not a Diannex binary translation file: invalid header";
		if (buffer_read(buff, buffer_u8) != ord("T"))
			throw "Not a Diannex binary translation file: invalid header";
			
		// Check format version
		if (buffer_read(buff, buffer_u8) != DIANNEX_FORMAT_VERSION_TRANSLATION)
			throw "Diannex translation binary format version is not compatible with this interpreter";
			
		// Load data!
		var stringCount = buffer_read(buff, buffer_u32);
		if (stringCount != array_length(text))
			throw "Translation file string count does not match";
		
		var i = 0;
		repeat (stringCount)
			text[i++] = buffer_read(buff, buffer_string);
		
		buffer_delete(buff);
		
		// Increment cache ID to account for new text
		currentCacheID++;
	};
	
	static initializeFlags = function()
	{
		if (flagsInitialized)
		{
			resetFlags();
			return false;
		}
		
		// Iterate over all scenes, initialize flags to default values
		var sceneArray = variable_struct_get_names(scenes);
		var len = array_length(sceneArray);
		for (var i = 0; i < len; i++)
		{
			var currentScene = scenes[$ sceneArray[i]];
			var flagOffsetsLen = array_length(currentScene.flagOffsets);
			for (var j = 0; j < flagOffsetsLen; j += 2)
			{
				var value = defaultInterpreter.executeEval(currentScene.flagOffsets[j]).getRawValue();
				var name = defaultInterpreter.executeEval(currentScene.flagOffsets[j + 1]).getRawValue();
				currentScene.flagNames[j / 2] = name;
				setFlagHandler(name, value);
			}
		}
		
		// Iterate over all functions, initialize flags to default values
		var len = array_length(functions);
		for (var i = 0; i < len; i++)
		{
			var currentFunc = functions[i];
			var flagOffsetsLen = array_length(currentFunc.flagOffsets);
			for (var j = 0; j < flagOffsetsLen; j += 2)
			{
				var value = defaultInterpreter.executeEval(currentFunc.flagOffsets[j]).getRawValue();
				var name = defaultInterpreter.executeEval(currentFunc.flagOffsets[j + 1]).getRawValue();
				currentFunc.flagNames[j / 2] = name;
				setFlagHandler(name, value);
			}
		}
		
		flagsInitialized = true;
		
		return true;
	};
	
	static resetFlags = function()
	{
		if (!flagsInitialized)
		{
			initializeFlags();
			return;
		}
		
		// Iterate over all scenes, initialize flags to default values, using names we already have
		var sceneArray = variable_struct_get_names(scenes);
		var len = array_length(sceneArray);
		for (var i = 0; i < len; i++)
		{
			var currentScene = scenes[$ sceneArray[i]];
			var flagOffsetsLen = array_length(currentScene.flagOffsets);
			for (var j = 0; j < flagOffsetsLen; j += 2)
			{
				var value = defaultInterpreter.executeEval(currentScene.flagOffsets[j]).getRawValue();
				var name = currentScene.flagNames[j / 2];
				setFlagHandler(name, value);
			}
		}
		
		// Iterate over all functions, initialize flags to default values, using names we already have
		var len = array_length(functions);
		for (var i = 0; i < len; i++)
		{
			var currentFunc = functions[i];
			var flagOffsetsLen = array_length(currentFunc.flagOffsets);
			for (var j = 0; j < flagOffsetsLen; j += 2)
			{
				var value = defaultInterpreter.executeEval(currentFunc.flagOffsets[j]).getRawValue();
				var name = currentFunc.flagNames[j / 2];
				setFlagHandler(name, value);
			}
		}
	};
}

function DiannexScene(buff, name) constructor
{
	self.name = name;
	var flagCount = buffer_read(buff, buffer_u16) - 1;
	if (flagCount != 0)
	{
		codeOffset = buffer_read(buff, buffer_s32);
		flagOffsets = array_create(flagCount);
		var j = 0;
		repeat (flagCount)
			flagOffsets[j++] = buffer_read(buff, buffer_s32);
		flagNames = array_create(flagCount / 2, undefined);
	}
	else
	{
		codeOffset = buffer_read(buff, buffer_s32);
		flagOffsets = [];
		flagNames = [];
	}
}

function DiannexFunction(buff, strings) constructor
{
	name = strings[buffer_read(buff, buffer_u32)];
	var flagCount = buffer_read(buff, buffer_u16) - 1;
	if (flagCount != 0)
	{
		codeOffset = buffer_read(buff, buffer_s32);
		flagOffsets = array_create(flagCount);
		var j = 0;
		repeat (flagCount)
			flagOffsets[j++] = buffer_read(buff, buffer_s32);
		flagNames = array_create(flagCount / 2, undefined);
	}
	else
	{
		codeOffset = buffer_read(buff, buffer_s32);
		flagOffsets = [];
		flagNames = [];
	}
}

function DiannexDefinition(buff) constructor
{
	valueStringIndex = buffer_read(buff, buffer_u32);
	codeOffset = buffer_read(buff, buffer_s32);
	
	if (valueStringIndex & (1 << 31))
	{
		// This uses the internal string table
		isInternal = true;
		valueStringIndex &= ~(1 << 31);
	}
	else
	{
		// This uses the translatable string table
		isInternal = false;
	}
}

function DiannexDefinitionInstance(target, interpreter) constructor
{
	self.target = target;
	self.interpreter = interpreter;
	data = interpreter.data;
	cachedValue = undefined;
	cachedID = -1; // used to invalidate the cache
	
	static getValue = function()
	{
		var currentID = data.currentCacheID;
		if (cachedID != currentID)
		{
			// Need to update the cached value
			cachedID = currentID;
			return getValueNoCache();
		}
		return cachedValue;
	};
	static getValueNoCache = function()
	{
		if (target.codeOffset != -1)
		{
			// Evalute string interpolation
			interpreter.executeEvalMultiple(target.codeOffset);
			var numElems = ds_stack_size(interpreter.stack);
			var elems = array_create(numElems);
			var i = 0;
			repeat (numElems)
				elems[i++] = string(ds_stack_pop(interpreter.stack).getRawValue());
				
			// Internal string
			if (target.isInternal)
			{
				cachedValue = interpreter.interpolateString(data.strings[target.valueStringIndex], elems);
				return cachedValue;
			}
		
			// Normal text
			cachedValue = interpreter.interpolateString(data.text[target.valueStringIndex], elems);
			return cachedValue;
		}
		
		// Internal string
		if (target.isInternal)
		{
			cachedValue = data.strings[target.valueStringIndex];
			return cachedValue;
		}
		
		// Normal text
		cachedValue = data.text[target.valueStringIndex];
		return cachedValue;
	};
}