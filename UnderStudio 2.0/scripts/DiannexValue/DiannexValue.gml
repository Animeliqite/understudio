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

enum DiannexValueType
{
	Integer,
	Double,
	String,
	Undefined,
	Array,
	Reference,
	Unknown
}

function __diannex_type_name(type)
{
	static names =
	[
		"Integer",
		"Double",
		"String",
		"Undefined",
		"Array",
		"Reference",
		"Unknown"
	];
	return names[type];
}

function __diannex_array_deep_convert(rawArray)
{
	var len = array_length(rawArray);
	var diannexValueArray = array_create(len);
	for (var i = 0; i < len; i++)
	    diannexValueArray[i] = new DiannexValue(rawArray[i]);
	return diannexValueArray;
}

function __diannex_array_deep_convert_reverse(diannexArray)
{
	var len = array_length(diannexArray);
	var rawArray = array_create(len);
	for (var i = 0; i < len; i++)
	{
	    if (diannexArray[i].type == DiannexValueType.Array)
	        rawArray[i] = __diannex_array_deep_convert_reverse(diannexArray[i].value);
		else
			rawArray[i] = diannexArray[i].value;
	}

	return rawArray;
}

/// @param {Any} val
function DiannexValue(val, 
					  type = DiannexValueType.Undefined) constructor
{
	value = val;
	if (type == DiannexValueType.Undefined)
	{
		// Manually determine the type
		if (is_struct(val) && instanceof(val) == "DiannexValue")
		{
			// This is a Diannex value itself!
			// Just copy over...
			value = val.value;
			self.type = val.type;
		}
		else if (is_undefined(val))
		{
			self.type = DiannexValueType.Undefined;
		}
		else if (is_array(val))
		{
			self.type = DiannexValueType.Array
			value = __diannex_array_deep_convert(val);
		}
		else if (is_string(val))
		{
			self.type = DiannexValueType.String;
		}
		else if ((is_real(val) && frac(val) == 0) || is_int32(val) || 
				  is_int64(val) || is_bool(val))
		{
			self.type = DiannexValueType.Integer;
		}
		else if (is_real(val))
		{
			self.type = DiannexValueType.Double;
		}
		else
		{
			// Unknown type - treat it as an immutable reference
			self.type = DiannexValueType.Reference;
		}
	}
	else
	{
		self.type = type;
	}
	
	static convert = function(newType)
	{
		if (type == newType || newType == DiannexValueType.Undefined)
			return self;
    
		switch (type)
		{
			case DiannexValueType.Double:
			    switch (newType)
			    {
			        case DiannexValueType.Integer:
						return new DiannexValue(floor(value), DiannexValueType.Integer);
					case DiannexValueType.String:
						return new DiannexValue(string(value), DiannexValueType.String);
			    }
			    break;
			case DiannexValueType.Integer:
			    switch (newType)
			    {
			        case DiannexValueType.Double:
						return new DiannexValue(real(value), DiannexValueType.Double);
			        case DiannexValueType.String:
						return new DiannexValue(string(value), DiannexValueType.String);
			    }
			    break;
			case DiannexValueType.String:
			    switch (newType)
			    {
			        case DiannexValueType.Double:
						return new DiannexValue(real(value), DiannexValueType.Double);
			        case DiannexValueType.Integer:
						return new DiannexValue(floor(real(value)), DiannexValueType.Integer);
			    }
			    break;
			case DiannexValueType.Undefined:
			    switch (newType)
			    {
			        case DiannexValueType.String:
						return new DiannexValue("undefined", DiannexValueType.String);
			    }
			    break;
		}

		throw "Cannot convert type " + __diannex_type_name(type) + " to " + __diannex_type_name(newType);
	};
	
	/// @returns {Any}
	static getRawValue = function()
	{
		if (type == DiannexValueType.Array)
			return __diannex_array_deep_convert_reverse(value);
		return value;
	};
	
	static add = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).add(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
		    case DiannexValueType.String:
				return new DiannexValue(value + otherValue.value, type);
		}

		throw "Cannot perform '+' with type " + __diannex_type_name(type);
	};
	
	static subtract = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).subtract(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value - otherValue.value, type);
		}

		throw "Cannot perform '-' with type " + __diannex_type_name(type);
	};
	
	static multiply = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).multiply(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value * otherValue.value, type);
		}

		throw "Cannot perform '*' with type " + __diannex_type_name(type);
	};
	
	static divide = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).divide(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value / otherValue.value, type);
		}

		throw "Cannot perform '/' with type " + __diannex_type_name(type);
	};
	
	static modulo = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).modulo(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value % otherValue.value, type);
		}

		throw "Cannot perform '%' with type " + __diannex_type_name(type);
	};
	
	static compareEQ = function(otherValue)
	{
		// If one or the other value is undefined, result is false
		if ((type == DiannexValueType.Undefined) != (otherValue.type == DiannexValueType.Undefined))
			return new DiannexValue(false, DiannexValueType.Integer);
			
		if (type != otherValue.type)
		    return self.convert(otherValue.type).compareEQ(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
		    case DiannexValueType.String:
				return new DiannexValue(value == otherValue.value, DiannexValueType.Integer);
		    case DiannexValueType.Undefined:
				return new DiannexValue(true, DiannexValueType.Integer);
		}

		throw "Cannot perform '==' with type " + __diannex_type_name(type);
	};
	
	static compareNEQ = function(otherValue)
	{	
		// If one or the other value is undefined, result is true
		if ((type == DiannexValueType.Undefined) != (otherValue.type == DiannexValueType.Undefined))
			return new DiannexValue(true, DiannexValueType.Integer);
			
		if (type != otherValue.type)
		    return self.convert(otherValue.type).compareNEQ(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
		    case DiannexValueType.String:
				return new DiannexValue(value != otherValue.value, DiannexValueType.Integer);
		    case DiannexValueType.Undefined:
				return new DiannexValue(false, DiannexValueType.Integer);
		}

		throw "Cannot perform '!=' with type " + __diannex_type_name(type);
	};
	
	static compareGT = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).compareGT(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value > otherValue.value, DiannexValueType.Integer);
		}

		throw "Cannot perform '>' with type " + __diannex_type_name(type);
	};
	
	static compareLT = function(otherValue)
	{
		if (type != otherValue.type)
		    return self.convert(otherValue.type).compareLT(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value < otherValue.value, DiannexValueType.Integer);
		}

		throw "Cannot perform '<' with type " + __diannex_type_name(type);
	};
	
	static compareGTE = function(otherValue)
	{	
		if (type != otherValue.type)
		    return self.convert(otherValue.type).compareGTE(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value >= otherValue.value, DiannexValueType.Integer);
		}

		throw "Cannot perform '>=' with type " + __diannex_type_name(type);
	};
	
	static compareLTE = function(otherValue)
	{	
		if (type != otherValue.type)
		    return self.convert(otherValue.type).compareLTE(otherValue);
    
		switch (type)
		{
		    case DiannexValueType.Double:
		    case DiannexValueType.Integer:
				return new DiannexValue(value <= otherValue.value, DiannexValueType.Integer);
		}

		throw "Cannot perform '<=' with type " + __diannex_type_name(type);
	};
}