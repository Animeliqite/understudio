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

enum DiannexInterpreterState
{
	Inactive,
	Running,
	Paused,
	InText,
	InChoice,
	Eval,
}

function DiannexInterpreter(binary) constructor
{
	data = binary;
	
	static unload = function()
	{
		if (!is_undefined(stack))
		{
			ds_stack_destroy(stack);
			stack = undefined;
		}
		if (!is_undefined(callStack))
		{
			ds_stack_destroy(callStack);
			callStack = undefined;
		}
		if (!is_undefined(locals))
		{
			ds_list_destroy(locals);
			locals = undefined;
		}
		if (!is_undefined(choiceOptions))
		{
			ds_list_destroy(choiceOptions);
			choiceOptions = undefined;
		}
		if (!is_undefined(chooseOptions))
		{
			ds_list_destroy(chooseOptions);
			chooseOptions = undefined;
		}
	};
	
	// Function handling
	functionHandlers = {};
	unregisteredFunctionHandler = function(name)
	{
		throw "Unregistered function \"" + name + "\"";
	};
	static registerFunction = function(name, func)
	{
		functionHandlers[$ name] = func;
	};
	
	// Other handlers
	textHandler = function(text)
	{
		throw "Missing text handler. Set variable 'textHandler' on the Diannex interpreter before using it.";
	};
	variableSetHandler = function(name, value)
	{
		throw "Missing variable set handler. Set variable 'variableSetHandler' on the Diannex interpreter before using it.";
	};
	variableGetHandler = function(name)
	{
		throw "Missing variable get handler. Set variable 'variableGetHandler' on the Diannex interpreter before using it.";
	};
	endSceneHandler = function(name)
	{
		// Does nothing by default
	};
	chanceHandler = function(chance)
	{
		return chance == 1 || random(1) < chance;
	};
	weightedChanceHandler = function(chances)
	{
		var sum = 0;
		var count = array_length(chances);
		var fixedWeights = array_create(count);
		for (var i = 0; i < count; i++)
		{
			fixedWeights[i] = sum;
			sum += chances[i];
		}
			
		var r = random(sum);
		var sel = -1, prev = -1;
		for (var i = 0; i < count; i++)
		{
			var curr = fixedWeights[i];
			if (r >= curr && curr > prev)
			{
				sel = i;
				prev = curr;
			}
		}
		
		return sel;
	};
	
	// Virtual machine
	state = DiannexInterpreterState.Inactive;
	programCounter = -1;
	var globalOpcodes = __diannex_get_opcodes();
	opcodes = array_create(256);
	for (var i = 0; i < 256; i++)
		opcodes[i] = method(self, globalOpcodes[i]);
	stack = ds_stack_create();
	callStack = ds_stack_create();
	locals = ds_list_create();
	choiceOptions = ds_list_create();
	chooseOptions = ds_list_create();
	saveRegister = undefined;
	flagCount = 0;
	currentScene = undefined;
	startingChoice = false;
	definitions = {}; // Local version of definitions
	
	static runScene = function(name)
	{
		currentScene = data.scenes[$ name];
		programCounter = currentScene.codeOffset;
		if (programCounter == -1)
			return;
		state = DiannexInterpreterState.Running;
		clearVMState();
		
		// Load flags into local variables
		var flagNames = currentScene.flagNames;
		flagCount = array_length(flagNames);
		for (var i = 0; i < flagCount; i++)
			ds_list_add(locals, new DiannexValue(data.getFlagHandler(flagNames[i])));
		
		var buff = data.instructions;
		while (state == DiannexInterpreterState.Running)
		{
			buffer_seek(buff, buffer_seek_start, programCounter);
			opcodes[buffer_read(buff, buffer_u8)](buff);
		}
	};
	
	static pauseScene = function()
	{
		if (state == DiannexInterpreterState.Running)
			state = DiannexInterpreterState.Paused;
	};
	
	static resumeScene = function()
	{
		if (state == DiannexInterpreterState.Paused ||
			state == DiannexInterpreterState.InText)
		{
			state = DiannexInterpreterState.Running;
		}
		
		var buff = data.instructions;
		while (state == DiannexInterpreterState.Running)
		{
			buffer_seek(buff, buffer_seek_start, programCounter);
			opcodes[buffer_read(buff, buffer_u8)](buff);
		}
	};
	
	static endScene = function()
	{
		state = DiannexInterpreterState.Inactive;
		var name = currentScene.name;
		currentScene = undefined;
		clearVMState();
		endSceneHandler(name);
	};
	
	static selectChoice = function(index)
	{
		if (state != DiannexInterpreterState.InChoice)
			throw "Attempting to select choice in invalid state";
		
		programCounter = choiceOptions[| index].targetOffset;
		ds_list_clear(choiceOptions);
		
		var buff = data.instructions;
		while (state == DiannexInterpreterState.Running)
		{
			buffer_seek(buff, buffer_seek_start, programCounter);
			opcodes[buffer_read(buff, buffer_u8)](buff);
		}
	};
	
	static getDefinition = function(name)
	{
		var def = definitions[$ name];
		if (is_undefined(def))
		{
			// Need to create the definition instance for this interpreter
			var baseDef = data.definitions[$ name];
			if (is_undefined(baseDef))
				return undefined;
			def = new DiannexDefinitionInstance(baseDef, self);
			definitions[$ name] = def;
		}
		return def.getValue();
	};
	
	static getDefinitionNoCache = function(name)
	{
		var def = definitions[$ name];
		if (is_undefined(def))
		{
			// Need to create the definition instance for this interpreter
			var baseDef = data.definitions[$ name];
			if (is_undefined(baseDef))
				return undefined;
			def = new DiannexDefinitionInstance(baseDef, self);
			definitions[$ name] = def;
		}
		return def.getValueNoCache();
	};
	
	static clearVMState = function()
	{
		ds_stack_clear(stack);
		ds_stack_clear(callStack);
		ds_list_clear(locals);
		ds_list_clear(choiceOptions);
		ds_list_clear(chooseOptions);
		saveRegister = undefined;
	};
	
	static executeEval = function(address)
	{
		if (state != DiannexInterpreterState.Inactive)
			throw "Invalid evaluation state in interpreter - make a separate interpreter?";
		
		state = DiannexInterpreterState.Eval;
		programCounter = address;
		
		var buff = data.instructions;
		while (state == DiannexInterpreterState.Eval)
		{
			buffer_seek(buff, buffer_seek_start, programCounter);
			opcodes[buffer_read(buff, buffer_u8)](buff);
		}
		
		return ds_stack_pop(stack);
	};
	static executeEvalMultiple = function(address)
	{
		if (state != DiannexInterpreterState.Inactive)
			throw "Invalid evaluation state in interpreter - make a separate interpreter?";
		
		state = DiannexInterpreterState.Eval;
		programCounter = address;
		
		var buff = data.instructions;
		while (state == DiannexInterpreterState.Eval)
		{
			buffer_seek(buff, buffer_seek_start, programCounter);
			opcodes[buffer_read(buff, buffer_u8)](buff);
		}
	};
	
	static interpolateString = function(str, elems)
	{
		var numElems = array_length(elems);
		
		var pos = 1;
		var len = string_length(str);
		var result = "";
		while (pos <= len)
		{
			var c = string_char_at(str, pos);
			if (c == "$" && (pos + 2) <= len)
			{
				var startPos = pos;
				var escaped = (pos > 1 && string_char_at(str, pos - 1) == "\\");
				if (string_char_at(str, pos + 1) == "{")
				{
					if (escaped)
					{
						// We'll be ignoring this since there's a backslash before it
						// But we need to remove the backslash from the result string
						result = string_delete(result, string_length(result), 1) + "$";
						pos++;
						continue;
					}
					
					pos += 2;
					
					// Read number
					var build = "";
					c = string_char_at(str, pos);
					do
					{
						build += c;
						pos++;
						c = string_char_at(str, pos);
					}
					until (c == "}" || pos > len);
					
					if (c != "}")
					{
						// Backtrack; ignore this
						pos = startPos + 1;
						result += "$";
						continue;
					}
					
					var index = -1;
					try
					{
						index = real(build);
					}
					catch (e)
					{
						// Backtrack; ignore this
						pos = startPos + 1;
						result += "$";
						continue;
					}
					
					if (index < 0 || index >= numElems)
					{
						// Backtrack; ignore this
						pos = startPos + 1;
						result += "$";
						continue;
					}
					
					result += elems[index];
				}
				else
				{
					result += c;
				}
			}
			else
			{
				result += c;
			}
			pos++;
		}
		
		return result;
	};
}

function DiannexStackFrame(returnOffset, stack, locals, flagCount) constructor
{
	self.returnOffset = returnOffset;
	self.stack = stack;
	self.locals = locals;
	self.flagCount = flagCount;
}

function DiannexChoice(targetOffset, text) constructor
{
	self.targetOffset = targetOffset;
	self.text = text;
}

function DiannexChooseEntry(targetOffset, chance) constructor
{
	self.targetOffset = targetOffset;
	self.chance = chance;
}