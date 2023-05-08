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

enum DiannexOpcode
{
	nop = 0x00, // No-op

    freeloc = 0x0A, // Frees a local variable from the stack frame (IF IT EXISTS!): [ID]

    // Special register instructions
    save = 0x0B, // Copy the value on the top of the stack into the save register
    load = 0x0C, // Push the value from the save register onto the top of the stack

    // Stack instructions
    pushu = 0x0F, // Push undefined value to stack
    pushi = 0x10, // Push 32-bit int: [int value]
    pushd = 0x11, // Push 64-bit floating point: [double value]

    pushs = 0x12, // Push external string: [index]
    pushints = 0x13, // Push external interpolated string: [index, expr count]
    pushbs = 0x14, // Push internal binary string: [ID]
    pushbints = 0x15, // Push internal binary interpolated string: [ID, expr count]

    makearr = 0x16, // Construct an array based off of stack: [size]
    pusharrind = 0x17, // Extract a single value out of an array, removing the array as well (uses stack for index)
    setarrind = 0x18, // Sets a value in an array on the top of the stack (uses stack for index and value)

    setvarglb = 0x19, // Set a global variable from the stack: [string name]
    setvarloc = 0x1A, // Set a local variable from the stack: [ID]
    pushvarglb = 0x1B, // Pushes a global variable to the stack: [string name]
    pushvarloc = 0x1C, // Pushes a local variable to the stack: [ID]

    pop = 0x1D, // Discards the value on the top of the stack
    dup = 0x1E, // Duplicates the value on the top of the stack
    dup2 = 0x1F, // Duplicates the values on the top two slots of the stack

    // Operators
    add = 0x20, // Adds the two values on the top of the stack, popping them, pushing the result
    sub = 0x21, // ditto, subtracts
    mul = 0x22, // ditto, multiplies
    _div = 0x23, // ditto, divides
    _mod = 0x24, // ditto, modulo
    neg = 0x25, // Negates the value on the top of the stack, popping it, pushing the result
    inv = 0x26, // ditto, but inverts a boolean

    bitls = 0x27, // Peforms bitwise left-shift using the top two values of stack, popping them, pushing the result
    bitrs = 0x28, // ditto, right-shift
    _bitand = 0x29, // ditto, and
    _bitor = 0x2A, // ditto, or
    bitxor = 0x2B, // ditto, xor
    bitneg = 0x2C, // ditto, negate (~)

    pow = 0x2D, // Power binary operation using top two values of stack

    cmpeq = 0x30, // Compares the top two values of stack to check if they are equal, popping them, pushing the result
    cmpgt = 0x31, // ditto, greater than
    cmplt = 0x32, // ditto, less than
    cmpgte = 0x33, // ditto, greater than or equal
    cmplte = 0x34, // ditto, less than or equal
    cmpneq = 0x35, // ditto, not equal

    // Control flow
    j = 0x40, // Jumps to an instruction [int relative address]
    jt = 0x41, // ditto, but if the value on the top of the stack is truthy (which it pops off)
    jf = 0x42, // ditto, but if the value on the top of the stack is NOT truthy (which it pops off)
    _exit = 0x43, // Exits the current stack frame
    ret = 0x44, // Exits the current stack frame, returning a value (from the stack, popping it off)
    call = 0x45, // Calls a function defined in the code [ID, int parameter count] 
    callext = 0x46, // Calls a function defined by a game [string name, int parameter count] 

    choicebeg = 0x47, // Switches to the choice state in the interpreter- no other choices can run and
                        // only one textrun can execute until after choicesel is executed
    choiceadd = 0x48, // Adds a choice, using the stack for the text and the % chance of appearing [int relative jump address]
    choiceaddt = 0x49, // ditto, but also if an additional stack value is truthy [int relative jump address]
    choicesel = 0x4A, // Pauses the interpreter, waiting for user input to select one of the choices, then jumps to one of them, resuming

    chooseadd = 0x4B, // Adds a new address to one of the possible next statements, using stack for chances [int relative jump address] (to the current stack frame)
    chooseaddt = 0x4C, // ditto, but also if an additional stack value is truthy [int relative jump address]
    choosesel = 0x4D, // Jumps to one of the choices, using the addresses and chances/requirement values on the stack

    textrun = 0x4E, // Pauses the interpreter, running a line of text from the stack
}

function __diannex_get_opcodes()
{
	static opcodes = undefined;
	if (!is_undefined(opcodes))
		return opcodes;
	
	opcodes = array_create(256, function() { programCounter++; });

	opcodes[DiannexOpcode.freeloc] = function()
	{
		programCounter += 5;
	
		var argIndex = buffer_read(data.instructions, buffer_s32);
		if (argIndex == ds_list_size(locals) - 1)
		{
			if (argIndex < flagCount)
			{
				// We're freeing an index which is one of the special "flag" locals
				var value = locals[| argIndex].getRawValue();
				if (!data.flagsInitialized)
					throw "Flags not initialized before being used by an interpreter";
				data.setFlagHandler(currentScene.flagNames[argIndex], value);
			}
				
			ds_list_delete(locals, argIndex);
		}
	};

	opcodes[DiannexOpcode.save] = function()
	{
		programCounter++;
		saveRegister = ds_stack_top(stack);
	};

	opcodes[DiannexOpcode.load] = function()
	{
		programCounter++;
		ds_stack_push(stack, saveRegister);
		saveRegister = undefined;
	};

	opcodes[DiannexOpcode.pushu] = function()
	{
		programCounter++;
		ds_stack_push(stack, new DiannexValue(undefined, DiannexValueType.Undefined));
	};

	opcodes[DiannexOpcode.pushi] = function()
	{
		programCounter += 5;
		ds_stack_push(stack, new DiannexValue(buffer_read(data.instructions, buffer_s32), DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode.pushd] = function()
	{
		programCounter += 9;
		ds_stack_push(stack, new DiannexValue(buffer_read(data.instructions, buffer_f64), DiannexValueType.Double));
	};


	opcodes[DiannexOpcode.pushs] = function()
	{
		programCounter += 5;
		ds_stack_push(stack, new DiannexValue(data.text[buffer_read(data.instructions, buffer_s32)], DiannexValueType.String));
	};

	opcodes[DiannexOpcode.pushints] = function()
	{
		programCounter += 9;
		var str = data.text[buffer_read(data.instructions, buffer_s32)];
		var numElems = buffer_read(data.instructions, buffer_s32);
		var i = 0;
		var elems = array_create(numElems);
		repeat (numElems)
			elems[i++] = string(ds_stack_pop(stack).getRawValue());
		ds_stack_push(stack, new DiannexValue(interpolateString(str, elems), DiannexValueType.String));
	};

	opcodes[DiannexOpcode.pushbs] = function()
	{
		programCounter += 5;
		ds_stack_push(stack, new DiannexValue(data.strings[buffer_read(data.instructions, buffer_s32)], DiannexValueType.String));
	};

	opcodes[DiannexOpcode.pushbints] = function()
	{
		programCounter += 9;
		var str = data.strings[buffer_read(data.instructions, buffer_s32)];
		var numElems = buffer_read(data.instructions, buffer_s32);
		var i = 0;
		var elems = array_create(numElems);
		repeat (numElems)
			elems[i++] = string(ds_stack_pop(stack).getRawValue());
		ds_stack_push(stack, new DiannexValue(interpolateString(str, elems), DiannexValueType.String));
	};


	opcodes[DiannexOpcode.makearr] = function()
	{
		programCounter += 5;
		var arg = buffer_read(data.instructions, buffer_s32);
		var arr = array_create(arg);
		for (var i = arg - 1; i >= 0; i--)
			arr[i] = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(arr, DiannexValueType.Array));
	};

	opcodes[DiannexOpcode.pusharrind] = function()
	{
		programCounter++;
		var ind = ds_stack_pop(stack).convert(DiannexValueType.Integer).getRawValue();
		var arr = ds_stack_pop(stack);
		if (arr.type != DiannexValueType.Array)
			throw "Array get on variable which is not an array";
		ds_stack_push(stack, arr.value[ind]);
	};

	opcodes[DiannexOpcode.setarrind] = function()
	{
		programCounter++;
		var value = ds_stack_pop(stack);
		var ind = ds_stack_pop(stack).convert(DiannexValueType.Integer).getRawValue();
		var arr = ds_stack_top(stack);
		if (arr.type != DiannexValueType.Array)
			throw "Array set on variable which is not an array";
		arr.value[ind] = value;
	};

	opcodes[DiannexOpcode.setvarglb] = function()
	{
		programCounter += 5;
		variableSetHandler(data.strings[buffer_read(data.instructions, buffer_s32)], ds_stack_pop(stack).getRawValue());
	};

	opcodes[DiannexOpcode.setvarloc] = function()
	{
		programCounter += 5;
		var value = ds_stack_pop(stack);
		var count = ds_list_size(locals);
	
		var argIndex = buffer_read(data.instructions, buffer_s32);
		if (argIndex >= count)
		{
			// Fill earlier local slots if necessary
			repeat (argIndex - count)
				ds_list_add(locals, new DiannexValue(undefined, DiannexValueType.Undefined));
		
			// Add new local
			ds_list_add(locals, value);
		}
		else
		{
			// Set existing local
			locals[| argIndex] = value;
		}
	};

	opcodes[DiannexOpcode.pushvarglb] = function()
	{
		programCounter += 5;
		ds_stack_push(stack, variableGetHandler(data.strings[buffer_read(data.instructions, buffer_s32)]));
	};

	opcodes[DiannexOpcode.pushvarloc] = function()
	{
		programCounter += 5;
		var argIndex = buffer_read(data.instructions, buffer_s32);
		if (argIndex >= ds_list_size(locals))
			ds_stack_push(stack, new DiannexValue(undefined, DiannexValueType.Undefined));
		ds_stack_push(stack, locals[| argIndex]);
	};

	opcodes[DiannexOpcode.dup] = function()
	{
		programCounter++;
		ds_stack_push(stack, ds_stack_top(stack));
	};

	opcodes[DiannexOpcode.dup2] = function()
	{
		programCounter++;
		var val1 = ds_stack_pop(stack);
		var val2 = ds_stack_pop(stack);
		ds_stack_push(stack, val2);
		ds_stack_push(stack, val1);
		ds_stack_push(stack, val2);
		ds_stack_push(stack, val1);
	};

	opcodes[DiannexOpcode.add] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.String || (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer))
			ds_stack_push(stack, val1.add(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).add(val2));
	};

	opcodes[DiannexOpcode.sub] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.subtract(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).subtract(val2));
	};

	opcodes[DiannexOpcode.mul] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.multiply(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).multiply(val2));
	};

	opcodes[DiannexOpcode._div] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.divide(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).divide(val2));
	};

	opcodes[DiannexOpcode._mod] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.modulo(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).modulo(val2));
	};

	opcodes[DiannexOpcode.neg] = function()
	{
		programCounter++;
		var val1 = ds_stack_pop(stack);
		switch (val1.type)
		{
			case DiannexValueType.Integer:
				ds_stack_push(stack, new DiannexValue(-val1.value, DiannexValueType.Integer));
				break;
			case DiannexValueType.Double:
				ds_stack_push(stack, new DiannexValue(-val1.value, DiannexValueType.Double));
				break;
			default:
				throw "Cannot negate type " + __diannex_type_name(val1.type);
		}
	};

	opcodes[DiannexOpcode.inv] = function()
	{
		programCounter++;
		var val1 = ds_stack_pop(stack);
		switch (val1.type)
		{
			case DiannexValueType.Integer:
				ds_stack_push(stack, new DiannexValue(!val1.value, DiannexValueType.Integer));
				break;
			case DiannexValueType.Double:
				ds_stack_push(stack, new DiannexValue(!val1.value, DiannexValueType.Double));
				break;
			default:
				throw "Cannot invert type " + __diannex_type_name(val1.type);
		}
	};

	opcodes[DiannexOpcode.bitls] = function()
	{			
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(val1.convert(DiannexValueType.Integer).value << val2.convert(DiannexValueType.Integer).value, DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode.bitrs] = function()
	{			
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(val1.convert(DiannexValueType.Integer).value >> val2.convert(DiannexValueType.Integer).value, DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode._bitand] = function()
	{
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(val1.convert(DiannexValueType.Integer).value & val2.convert(DiannexValueType.Integer).value, DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode._bitor] = function()
	{
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(val1.convert(DiannexValueType.Integer).value | val2.convert(DiannexValueType.Integer).value, DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode.bitxor] = function()
	{
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(val1.convert(DiannexValueType.Integer).value ^ val2.convert(DiannexValueType.Integer).value, DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode.bitneg] = function()
	{
		programCounter++;
		ds_stack_push(stack, new DiannexValue(~(ds_stack_pop(stack).convert(DiannexValueType.Integer).value), DiannexValueType.Integer));
	};

	opcodes[DiannexOpcode.pow] = function()
	{
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		ds_stack_push(stack, new DiannexValue(power(val1.convert(DiannexValueType.Double).value, val2.convert(DiannexValueType.Double).value), DiannexValueType.Double));
	};

	opcodes[DiannexOpcode.cmpeq] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.compareEQ(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).compareEQ(val2));
	};

	opcodes[DiannexOpcode.cmpgt] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.compareGT(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).compareGT(val2));
	};

	opcodes[DiannexOpcode.cmplt] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.compareLT(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).compareLT(val2));
	};

	opcodes[DiannexOpcode.cmpgte] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.compareGTE(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).compareGTE(val2));
	};

	opcodes[DiannexOpcode.cmplte] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.compareLTE(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).compareLTE(val2));
	};

	opcodes[DiannexOpcode.cmpneq] = function()
	{				
		programCounter++;
		var val2 = ds_stack_pop(stack);
		var val1 = ds_stack_pop(stack);
		if (val1.type == DiannexValueType.Double && val2.type == DiannexValueType.Integer)
			ds_stack_push(stack, val1.compareNEQ(val2.convert(val1.type)));
		else
			ds_stack_push(stack, val1.convert(val2.type).compareNEQ(val2));
	};

	opcodes[DiannexOpcode.j] = function()
	{
		programCounter += (5 + buffer_read(data.instructions, buffer_s32));
	
	};

	opcodes[DiannexOpcode.jt] = function()
	{
		var argJump = buffer_read(data.instructions, buffer_s32);
		if (ds_stack_pop(stack).convert(DiannexValueType.Integer).value != 0)
			programCounter += (5 + argJump);
		else
			programCounter += 5;
	};

	opcodes[DiannexOpcode.jf] = function()
	{
		var argJump = buffer_read(data.instructions, buffer_s32);
		if (ds_stack_pop(stack).convert(DiannexValueType.Integer).value == 0)
			programCounter += (5 + argJump);
		else
			programCounter += 5;
	};

	opcodes[DiannexOpcode._exit] = function()
	{
		programCounter++;
		if (state == DiannexInterpreterState.Eval)
		{
			// Exit evaluation state
			state = DiannexInterpreterState.Inactive;
		}
		else
		{
			if (ds_stack_size(callStack) == 0)
			{
				// Nowhere else to exit to; end scene execution
				endScene();
			}
			else
			{
				// Returning from a function
				var lastFrame = ds_stack_pop(callStack);
				programCounter = lastFrame.returnOffset;
				ds_stack_destroy(stack);
				stack = lastFrame.stack;
				ds_list_destroy(locals);
				locals = lastFrame.locals;
				flagCount = lastFrame.flagCount;
			
				// No return value specified, so use undefined
				ds_stack_push(stack, new DiannexValue(undefined, DiannexValueType.Undefined));
			}
		}
	};

	opcodes[DiannexOpcode.ret] = function()
	{
		programCounter++;
	
		if (ds_stack_size(callStack) == 0)
		{
			// Nowhere else to exit to; end scene execution
			endScene();
		}
		else
		{
			// Returning from a function
			var returnValue = ds_stack_pop(stack);
				
			var lastFrame = ds_stack_pop(callStack);
			programCounter = lastFrame.returnTo;
			ds_stack_destroy(stack);
			stack = lastFrame.stack;
			ds_list_destroy(locals);
			locals = lastFrame.locals;
		
			// Push return value to calling frames' stack
			ds_stack_push(stack, returnValue);
		}
	};

	opcodes[DiannexOpcode.call] = function()
	{
		programCounter += 9;
	
		var argFuncIndex = buffer_read(data.instructions, buffer_s32);
		var argCount = buffer_read(data.instructions, buffer_s32);
	
		var args = array_create(argCount);
		for (var i = 0; i < argCount; i++) // arguments in stack are in correct order
			args[i] = ds_stack_pop(stack);
			
		ds_stack_push(callStack, new DiannexStackFrame(programCounter, stack, locals, flagCount));
		var func = data.functions[argFuncIndex];
		programCounter = func.codeOffset;
		stack = ds_stack_create();
		locals = ds_list_create();
		
		// Load flags into local variables
		var flagNames = func.flagNames;
		flagCount = array_length(flagNames);
		for (var i = 0; i < flagCount; i++)
			ds_list_add(locals, new DiannexValue(data.getFlagHandler(flagNames[i])));
	
		// Load arguments into local variables
		for (var i = 0; i < argCount; i++)
			ds_list_add(locals, args[i]);
	};

	opcodes[DiannexOpcode.callext] = function()
	{
		programCounter += 9;
	
		var argFuncName = data.strings[buffer_read(data.instructions, buffer_s32)];
		var argCount = buffer_read(data.instructions, buffer_s32);
	
		var args = array_create(argCount);
		for (var i = 0; i < argCount; i++) // arguments in stack are in correct order
			args[i] = ds_stack_pop(stack);
		
		var handler = functionHandlers[$ argFuncName] ?? unregisteredFunctionHandler;
		ds_stack_push(stack, new DiannexValue(script_execute_ext(handler, args)));
	};

	opcodes[DiannexOpcode.choicebeg] = function()
	{
		if (state != DiannexInterpreterState.Running || startingChoice)
			throw "Invalid choice begin state";
	
		programCounter++;
		startingChoice = true;
	};

	opcodes[DiannexOpcode.choiceadd] = function()
	{
		if (!startingChoice)
			throw "Invalid choice add state";
	
		programCounter += 5;
	
		var chance = ds_stack_pop(stack).convert(DiannexValueType.Double).value;
		var text = ds_stack_pop(stack).value;
		if (chanceHandler(chance))
			ds_list_add(choiceOptions, new DiannexChoice(programCounter + buffer_read(buff, buffer_s32), text)); 
		startingChoice = true;
	};

	opcodes[DiannexOpcode.choiceaddt] = function()
	{
		if (!startingChoice)
			throw "Invalid choice add state";
	
		programCounter += 5;
	
		var condition = ds_stack_pop(stack).convert(DiannexValueType.Integer).value;
		var chance = ds_stack_pop(stack).convert(DiannexValueType.Double).value;
		var text = ds_stack_pop(stack).value;
		if (condition.val != 0 && chanceHandler(chance))
			ds_list_add(choiceOptions, new DiannexChoice(programCounter + buffer_read(buff, buffer_s32), text)); 
		startingChoice = true;
	};

	opcodes[DiannexOpcode.choicesel] = function()
	{
		programCounter++;
	
		if (!startingChoice)
			throw "Invalid choice selection state";
		if (ds_list_size(choiceOptions) == 0)
			throw "Choice statement has no choices to present";
		
		startingChoice = false;
		state = DiannexInterpreterState.InChoice;
			
		var count = ds_list_size(choiceOptions);
		var textChoices = array_create(count);
		for (var i = 0; i < count; i++)
			textChoices[i] = choiceOptions[| i].text;
		choiceHandler(textChoices);
	};

	opcodes[DiannexOpcode.chooseadd] = function(buff)
	{
		programCounter += 5;
		ds_list_add(chooseOptions, new DiannexChooseEntry(programCounter + buffer_read(buff, buffer_s32), 
													      ds_stack_pop(stack).convert(DiannexValueType.Double).value));
	};

	opcodes[DiannexOpcode.chooseaddt] = function(buff)
	{
		programCounter += 5;
		var condition = ds_stack_pop(stack).convert(DiannexValueType.Integer).value;
		var chance = ds_stack_pop(stack).convert(DiannexValueType.Double).value;
		if (condition != 0)
			ds_list_add(chooseOptions, new DiannexChooseEntry(programCounter + buffer_read(buff, buffer_s32), chance));
	};

	opcodes[DiannexOpcode.choosesel] = function(buff)
	{
		programCounter++;
	
		var count = ds_list_size(chooseOptions);
		if (count == 0)
			throw "No entries for choose statement";
	
		var chooseWeights = array_create(count);
		for (var i = 0; i < count; i++)
			chooseWeights[i] = chooseOptions[| i].chance;
	
		programCounter = chooseOptions[| weightedChanceHandler(chooseWeights)].targetOffset;
		ds_list_clear(chooseOptions);
	};

	opcodes[DiannexOpcode.textrun] = function()
	{
		if (state != DiannexInterpreterState.Running)
			throw "Invalid text run state";
	
		programCounter++;
		state = DiannexInterpreterState.InText;
		textHandler(ds_stack_pop(stack).convert(DiannexValueType.String).getRawValue());
	};
	
	return opcodes;
}