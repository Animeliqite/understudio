// Make sure TweenGMS is initialized
TGMS_Begin();


/// @func TPFunc(target, name, setter, [getter])
function TPFunc(target, name, setter)
{	
	static _assignName = "";
	setter = method(target, setter);
	
	// Don't think this is needed... users can use wildcard "*" directly
	//if (is_real(name) || name == "") { name = "*" }
	
	// Check for "<" or ">" to/from and strip it for variable name assignment
	if (string_byte_at(name, string_length(name)) == 60 || string_byte_at(name, string_length(name)) == 62){
		_assignName = string_delete(name, string_length(name), 1);
	}
	else{
		_assignName = name;	
	}
	
	// Connect setter method
	target[$ global.TGMS_STR_DOLLAR+_assignName] = setter;
	
	// Connect getter method
	if (argument_count == 4 && argument[3] != undefined){
		target[$ global.TGMS_STR_AMPERSAND+_assignName] = method(target, argument[3]);
	}
	
	// This allows us to place this directly into a tween function if desired
	return name;
}


/// @func TPFuncShared(name, setter, [getter])
/// @desc Prepares a property to be optimised for TweenGMS
function TPFuncShared(name, setter) 
{
	/// @param "name"		string to associate with property
	/// @param setter		setter function to associate with property
	/// @param [getter]		(optional) getter function to associate with property
	
	// Make sure system is already started
	TGMS_Begin();

	// Associate shared variable name with a setter function for all targets
	global.TGMS_PropertySetters[? name] = method(global.TGMS, setter);

	if (argument_count == 3 && argument[2] != undefined)
	{
		global.TGMS_PropertyGetters[? name] = method(global.TGMS, argument[2]);
	}
}


/// @func TPFuncSharedNormal(name, setter, [getter])
/// @desc Prepares a normalized property to be usable by TweenGMS
function TPFuncSharedNormal(name, setter) 
{
	/*
		Normalized property scripts receive an eased value between 0 and 1
		with additional data passed for the start/dest values.
	*/
	
	if (argument_count == 2)
	{
		TPFuncShared(name, setter);	
	}
	else
	{
		TPFuncShared(name, setter, argument[2]);	
	}

	// Mark as a shared normalized property
	global.TGMS_PropertyNormals[? name] = 1;
}


//==============================
// DEFAULT INSTANCE PROPERTIES
//==============================
TPFuncShared("",					function(){}, function(){});
TPFuncShared("x",					function(v,t){t.x = v});
TPFuncShared("y",					function(v,t){t.y = v});
TPFuncShared("z",					function(v,t){t.z = v});
TPFuncShared("direction",			function(v,t){t.direction = v});
TPFuncShared("speed",				function(v,t){t.speed = v});
TPFuncShared("hspeed",				function(v,t){t.hspeed = v});
TPFuncShared("vspeed",				function(v,t){t.vspeed = v});
TPFuncShared("image_angle",			function(v,t){t.image_angle = v});
TPFuncShared("image_alpha",			function(v,t){t.image_alpha = v});
TPFuncShared("image_speed",			function(v,t){t.image_speed = v});
TPFuncShared("image_index",			function(v,t){t.image_index = v});
TPFuncShared("image_xscale",		function(v,t){t.image_xscale = v});
TPFuncShared("image_yscale",		function(v,t){t.image_yscale = v});
TPFuncShared("image_scale",			function(v,t){t.image_xscale = v; t.image_yscale = v; }, function(t){ return t.image_xscale });
TPFuncSharedNormal("image_blend",	function(v,t,d){ t.image_blend = merge_colour(d[0], d[1], v) });
TPFuncShared("path_position",		function(v,t){t.path_position = v});
TPFuncShared("path_scale",			function(v,t){t.path_scale = v});
TPFuncShared("path_speed",			function(v,t){t.path_speed = v});
TPFuncShared("path_orientation",	function(v,t){t.path_orientation = v});
TPFuncShared("depth",				function(v,t){t.depth = v});
TPFuncShared("friction",			function(v,t){t.friction = v});
TPFuncShared("gravity",				function(v,t){t.gravity = v});
TPFuncShared("gravity_direction",	function(v,t){t.gravity_direction = v});


//
// Property Modifiers
//
function TPCeil(property)			{ return [TPCeil, property]; }
function TPFloor(property)			{ return [TPFloor, property]; }
function TPRound(property)			{ return [TPRound, property]; }
function TPShake(property, amount)	{ return [TPShake, property, amount]; }
function TPSnap(property, snap)		{ return [TPSnap, property, snap]; }

//
//	Data Structures
//
function TPArray(array, index)  { return [TPArray, array, index]; }
function TPGrid(grid, x, y)		{ return [TPGrid, grid, x, y]; }
function TPList(list, index)	{ return [TPList, list, index]; }
function TPMap(map, key)		{ return [TPMap, map, key]; }

//
// Special Properties
//
function TPTarget(target, name) { return [TPTarget, is_real(target) ? target : weak_ref_create(target), name]; }
function TPCol(property)		{ return [TPCol, property]; }
function TPPath(path, absolute) { return [TPPath, path, absolute]; }
function TPPathExt(path, x, y)	{ return [TPPath, path, x, y]; }
function TPUser(user_event)		
{ 
	if (argument_count == 1) { return [TPUser, user_event, undefined]; }
	if (argument_count == 2) { return [TPUser, user_event, argument[1]]; }
	static i = -1; i = -1; 
	static args = 0; args = array_create(argument_count-1);
	repeat(argument_count-1) { ++i; args[i] = argument[i+1]; }
	return [TPUser, user_event, args]; 
}


/// TPCeil(value, target, variable) 
global.TGMS.SET_TPCeil = function(argument0, argument1, argument2, argument3) 
{
	/*
		Example:
			TweenFire("$", 60, TPCeil("x"), x, mouse_x)
	*/
	if (is_array(argument2))
	{
		var _array = argument2[0];
		var _data;
		var _length = array_length(_array)-1;
	
		if (_length == 1)
		{	
			_data = _array[1];
		}
		else
		{
			_data = array_create(_length);
			array_copy(_data, 0, _array, 1, _length);
		}
	
		var _script = _array[0];
		_script(ceil(argument0), argument1, _data, argument3);
	}
	else
	if (ds_map_exists(global.TGMS_PropertySetters, argument2))
	{
		global.TGMS_PropertySetters[? argument2](ceil(argument0), argument1);
	}
	else
	if (variable_instance_exists(argument1, argument2))
	{
		variable_instance_set(argument1, argument2, ceil(argument0));
	}
	else
	{
		variable_global_set(argument2, ceil(argument0));
	}
}

/// TPFloor(value, target, variable)
global.TGMS.SET_TPFloor = function(argument0, argument1, argument2, argument3) {
	/*
		Example:
			TweenFire("$", 60, [TPFloor, "x"], x, mouse_x)
	*/
	if (is_array(argument2))
	{
		var _array = argument2[0];
		var _data;
		var _length = array_length(_array)-1;
	
		if (_length == 1)
		{	
			_data = _array[1];
		}
		else
		{
			_data = array_create(_length);
			array_copy(_data, 0, _array, 1, _length);
		}
	
		var _script = _array[0];
		_script(floor(argument0), argument1, _data, argument3);
	}
	else
	if (ds_map_exists(global.TGMS_PropertySetters, argument2))
	{
		global.TGMS_PropertySetters[? argument2](floor(argument0), argument1);
	}
	else
	if (variable_instance_exists(argument1, argument2))
	{
		variable_instance_set(argument1, argument2, floor(argument0));
	}
	else
	{
		variable_global_set(argument2, floor(argument0));
	}
}

/// TPRound(value, target, variable)
global.TGMS.SET_TPRound = function(argument0, argument1, argument2, argument3) {
	/*
		Example:
			TweenFire("$", 60, [TPRound, "x"], x, mouse_x)
	*/
	if (is_array(argument2))
	{
		var _array = argument2[0];	
		var _data;
		var _length = array_length(_array)-1;
	
		if (_length == 1)
		{	
			_data = _array[1];
		}
		else
		{
			_data = array_create(_length);
			array_copy(_data, 0, _array, 1, _length);
		}
	
		var _script = _array[0];
		_script(round(argument0), argument1, _data, argument3);
	}
	else
	if (ds_map_exists(global.TGMS_PropertySetters, argument2))
	{
		global.TGMS_PropertySetters[? argument2](round(argument0), argument1);
	}
	else
	if (variable_instance_exists(argument1, argument2))
	{
		variable_instance_set(argument1, argument2, round(argument0));
	}
	else
	{
		variable_global_set(argument2, round(argument0));
	}
}

/// TPShake(value, target, [variable,shake], tween)
global.TGMS.SET_TPShake = function(argument0, argument1, argument2, _t) {
	/*
		Example:
			TweenFire("$", 60, [TPShake, "x", 10], x, mouse_x)
	*/
	if (_t[TWEEN.TIME] > 0 && _t[TWEEN.TIME] < _t[TWEEN.DURATION])
	{
		argument0 += random_range(-argument2[1], argument2[1])
	}
	
	if (is_array(argument2[0]))
	{
		var _array = argument2[0];
		var _data;
		var _length = array_length(_array)-1;
	
		if (_length == 1)
		{	
			_data = _array[1];
		}
		else
		{
			_data = array_create(_length);
			array_copy(_data, 0, _array, 1, _length);
		}
	
		var _script = _array[0];
		_script(argument0, argument1, _data, _t);
	}
	else
	if (ds_map_exists(global.TGMS_PropertySetters, argument2[0]))
	{
		var _script = global.TGMS_PropertySetters[? argument2[0]];
		_script(argument0, argument1, argument2[0], argument3); // Left in some future-proofing
		//global.TGMS_PropertySetters[? argument2[0]](argument0, argument1, argument2[0], argument3); // Left in some future-proofing
	}
	else
	if (variable_instance_exists(argument1, argument2[0]))
	{
		variable_instance_set(argument1, argument2[0], argument0);
	}
	else
	{
		variable_global_set(argument2[0], argument0);
	}
}

/// TPSnap(value, target, [variable,snap])
global.TGMS.SET_TPSnap = function(argument0, argument1, argument2, argument3)
{
	argument0 = 10000 * argument0 div (10000*argument2[1]) * (10000*argument2[1]) / 10000;

	if (is_array(argument2[0]))
	{
		var _array = argument2[0];
		var _data;
		var _length = array_length(_array)-1;
	
		if (_length == 1)
		{	
			_data = _array[1];
		}
		else
		{
			_data = array_create(_length);
			array_copy(_data, 0, _array, 1, _length);
		}
	
		var _script = _array[0];
		_script(argument0, argument1, _data, argument3);
	}
	else
	{
		if (ds_map_exists(global.TGMS_PropertySetters, argument2[0]))
		{	
			var _script = global.TGMS_PropertySetters[? argument2[0]];
			_script(argument0, argument1);
			//global.TGMS_PropertySetters[? argument2[0]](argument0, argument1);
		}
		else
		if (variable_instance_exists(argument1, argument2[0]))
		{	
			variable_instance_set(argument1, argument2[0], argument0);
		}
		else
		{	
			variable_global_set(argument2[0], argument0);
		}
	}
}


//============================
// Data Structure Properties
//============================
global.TGMS.GET_Array = function(target, data) 
{
	if (is_string(data[0])) 
	{ 
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	return data[0][data[1]]; 
}

global.TGMS.SET_Array = function(value, target, data) 
{
	if (is_string(data[0])) 
	{ 
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	array_set(data[0], data[1], value);
}

global.TGMS.GET_Grid = function(target, data) 
{
	if (is_string(data[0]))
	{
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	return ds_grid_get(data[0], data[1], data[2]);
}

global.TGMS.SET_Grid = function(value, target, data) 
{
	if (is_string(data[0]))
	{
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	ds_grid_set(data[0], data[1], data[2], value);
}
	
global.TGMS.GET_List = function(target, data) 
{
	if (is_string(data[0]))
	{
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);	
	}

	return ds_list_find_value(data[0], data[1]);
}

global.TGMS.SET_List = function(value, target, data) 
{
	if (is_string(data[0]))
	{
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	ds_list_replace(data[0], data[1], value);
}

global.TGMS.GET_Map = function(target, data) 
{
	if (is_string(data[0]))
	{
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	return ds_map_find_value(data[0], data[1]);
}

global.TGMS.SET_Map = function(value, target, data) 
{
	if (is_string(data[0]))
	{
		data[@ 0] = variable_instance_exists(target, data[0]) ? variable_instance_get(target, data[0]) : variable_global_get(data[0]);
	}
	
	ds_map_replace(data[0], data[1], value);
}


//
//	SPECIAL PROPERTIES
//
global.TGMS.Variable_Target_Get = function(target, data, tween)
{
	if (is_real(data[1]))
	{
		return data[1].id[$ data[0]];
	}
	else
	{
		return (data[1].ref[$ data[0]]);
	}
}

/// TPCol(value, target, [variable,col1,col2])
global.TGMS.SET_TPCol = function(value, target, data) 
{
	if (variable_instance_exists(target, data[0]))
	{
		variable_instance_set(target, data[0], merge_colour(data[1], data[2], value));
	}
	else
	{
		variable_global_set(data[0], merge_colour(data[1], data[2], value));
	}
}

global.TGMS.GET_TPUser = function(target, data, event) 
{
	TWEEN_USER_GET = 1;
	TWEEN_USER_TARGET = target;
	TWEEN_USER_DATA = data[1];
	
	if (TGMS_OPTIMISE_USER)
	{
		event_perform_object(TWEEN_USER_TARGET.object_index, ev_other, ev_user0+data[0]);
	}
	else
	with(TWEEN_USER_TARGET)
	{
		event_user(data[0]);
	}
	
	data = TWEEN_USER_GET; // Repurpose 'data' to avoid var overhead
	TWEEN_USER_GET = 0;
	return data;
}

global.TGMS.SET_TPUser = function(value, target, data) 
{
	TWEEN_USER_VALUE = value;
	TWEEN_USER_TARGET = target;
	TWEEN_USER_DATA = data[1];
	
	if (TGMS_OPTIMISE_USER)
	{
		event_perform_object(target.object_index, ev_other, ev_user0+data[0]);
	}
	else
	with(TWEEN_USER_TARGET)
	{
		event_user(data[0]);
	}
}

// NOTE: This might not work properly...
global.TGMS.GET_TPPath = function(target, data, tween) 
{
	return target.path_position;	
}

/// TPPath(amount,target,[path|x|y],tween)
global.TGMS.SET_TPPath = function(amount, target, pathData, tween) 
{
	var _path, _xstart, _ystart, _xrelative, _yrelative;
	
	if (is_real(pathData))
	{	// ABSOLUTE
		_path = pathData;
		_xstart = path_get_x(_path, 0);
		_ystart = path_get_y(_path, 0);
		_xrelative = 0;
		_yrelative = 0;
	}
	else
	{
		_path = pathData[0];
		_xstart = path_get_x(_path, 0);
		_ystart = path_get_y(_path, 0);
	
		if (array_length(pathData) == 3)
		{
			_xrelative = pathData[1] - _xstart;
			_yrelative = pathData[2] - _ystart;
		}
		else
		if (pathData[1]) // Absolute
		{
			_xrelative = 0;
			_yrelative = 0;
		}
		else
		{
			_xrelative = target.x - _xstart;
			_yrelative = target.y - _ystart;
			pathData[@ 1] = target.x; // Right... if I don't do this, it'll always use the update x/y position to offset.. which is wrong!
			pathData[@ 2] = target.y;
		}
	}

	if (tween[TWEEN.MODE] == TWEEN_MODE_REPEAT)
	{
		var _xDif = path_get_x(_path, 1) - _xstart;
		var _yDif = path_get_y(_path, 1) - _ystart;
            
		if (amount >= 0)
		{   
			_xrelative += _xDif * floor(amount); 
			_yrelative += _yDif * floor(amount);
			amount = amount % 1;
		}
		else 
		if (amount < 0)
		{
			_xrelative += _xDif * ceil(amount-1);
			_yrelative += _yDif * ceil(amount-1);
			amount = 1 + amount % 1;
		}
			
		target.x = path_get_x(_path, amount) + _xrelative;
		target.y = path_get_y(_path, amount) + _yrelative;
	}
	else
	if (amount > 0)
	{
		if (path_get_closed(_path) || amount < 1)
		{
			target.x = path_get_x(_path, amount % 1) + _xrelative;
			target.y = path_get_y(_path, amount % 1) + _yrelative;
		}
		else
		{
			var _length = path_get_length(_path) * (abs(amount)-1);
			var _direction = point_direction(path_get_x(_path, 0.999), path_get_y(_path, 0.999), path_get_x(_path, 1), path_get_y(_path, 1));
                
			target.x = path_get_x(_path, 1) + _xrelative + lengthdir_x(_length, _direction);
			target.y = path_get_y(_path, 1) + _yrelative + lengthdir_y(_length, _direction);
		}
	}
	else 
	if (amount < 0)
	{
		if (path_get_closed(_path))
		{
			target.x = path_get_x(_path, 1+amount) + _xrelative;
			target.y = path_get_y(_path, 1+amount) + _yrelative;
		}
		else
		{
			var _length = path_get_length(_path) * abs(amount);
			var _direction = point_direction(_xstart, _ystart, path_get_x(_path, 0.001), path_get_y(_path, 0.001));
                
			target.x = _xstart + _xrelative - lengthdir_x(_length, _direction);
			target.y = _ystart + _yrelative - lengthdir_y(_length, _direction);
		}
	}
	else // amount == 0
	{
		target.x = _xstart + _xrelative;
		target.y = _ystart + _yrelative;
	}
}

//=========================
// AUTO PROPERTIES
//=========================

// NOTE: Do not try to optimise these checks. They need to be checked each time anyway.
// NOTE: Keep this as a function to improve performance!!
function TGMS_Variable_Get(target, variable, caller) 
{	
	// ADVANCED ARRAY
	if (is_array(variable))
	{	
		// SCRIPT -- Return
		if (ds_map_exists(global.TGMS_PropertyGetters, variable[0])) 
		{
			return global.TGMS_PropertyGetters[? variable[0]](target, variable[1]);
		}

		// Get variable string from advanced data and keep executing below...
		variable = variable[1];
		// Get variable string from inner array if WE MUST GO DEEPER! Muhahaha
		if (is_array(variable)) { variable = variable[0] }
	}

	// METHOD
	if (target[$ global.TGMS_STR_AMPERSAND+variable] != undefined)
	{	
		return target[$ global.TGMS_STR_AMPERSAND+variable](target, variable);
	}

	// FUNCTION
	if (ds_map_exists(global.TGMS_PropertyGetters, variable)) 
	{
		return global.TGMS_PropertyGetters[? variable](target);
	}

	// INSTANCE
	if (target[$ variable] != undefined)
	{
		return target[$ variable];
	}
	
	// CALLER
	if (caller[$ variable] != undefined)
	{
		return caller[$ variable];
	}
	
	// GLOBAL
	if (variable_global_exists(variable)) 
	{
		return variable_global_get(variable);
	}
	
	// NUMBER
	if (string_byte_at(variable, 1) <= 57) 
	{
		return real(variable);
	}
	
	// EXPRESSION -- NOTE: This needs to be extended to allow for global.thing.otherthing
	static _prefix = 0;
	static _postfix = 0;
	_prefix = string_copy( variable, 1, string_pos(global.TGMS_STR_DOT, variable)-1 );
	_postfix = string_copy(variable, 1+string_pos(global.TGMS_STR_DOT, variable), 100);
	
	// Object variable
	if (object_exists(asset_get_index(_prefix)))
	{
		return variable_instance_get(asset_get_index(_prefix).id, _postfix);
	}

	// Caller variable
	if (_prefix == global.TGMS_STR_SELF)
	{
		return caller[$ _postfix]
	}
	
	// Global variable
	if (_prefix == global.TGMS_STR_GLOBAL)
	{
		return variable_global_get(_postfix);
	}
	
	// Target variable
	if (target[$ _prefix] != undefined)
	{
		_prefix = target[$ _prefix];
		return _prefix[$ _postfix];
	}

	// Caller variable
	if (caller[$ _prefix] != undefined)
	{
		_prefix = caller[$ _prefix];
		return _prefix[$ _postfix];
	}

	// Global
	_prefix = variable_global_get(_prefix);
	return _prefix[$ _postfix];
}

// Default global property setter
global.TGMS.Variable_Global_Set = function(value, null, variable) 
{
	variable_global_set(variable, value);
	return null; // Prevent complaint about unused 'null' (target)
}

// Default instance property setter
global.TGMS.Variable_Instance_Set = function(value, target, variable) 
{
	target[$ variable] = value;
}


global.TGMS.Variable_Target_Set = function(value, target, variable) 
{
	/// @param value
	/// @param target
	/// @param variable[name,struct]
	
	target = variable[1];

	if (is_real(target))
	{
		target[$ variable[0]] = value;
	}
	else
	{
		target.ref[$ variable[0]] = value;
	}
}

/// @func global.TGMS.Variable_Struct_String_Set(value, target, variable)
global.TGMS.Variable_Struct_String_Set = function(value, target, variable) 
{
	/// @param value
	/// @param null
	/// @param variable[name,struct]

	target = variable[0];
	
	if (is_real(target))
	{
		target[$ variable[1]] = value;
	}
	else
	{
		target.ref[$ variable[1]] = value;
	}
}


//
//	Implement Property Modifiers
//
TPFuncShared(TPCeil, global.TGMS.SET_TPCeil);
TPFuncShared(TPFloor, global.TGMS.SET_TPFloor);
TPFuncShared(TPRound, global.TGMS.SET_TPRound);
TPFuncShared(TPShake, global.TGMS.SET_TPShake);
TPFuncShared(TPSnap, global.TGMS.SET_TPSnap);

//
// BUILD DATA STRUCTURE PROPERTIES
//
TPFuncShared(TPArray, global.TGMS.SET_Array, global.TGMS.GET_Array);
TPFuncShared(TPList, global.TGMS.SET_List, global.TGMS.GET_List);
TPFuncShared(TPGrid, global.TGMS.SET_Grid, global.TGMS.GET_Grid);
TPFuncShared(TPMap, global.TGMS.SET_Map, global.TGMS.GET_Map);

//
//	Set Special Properties
//	
TPFuncShared(TPTarget, global.TGMS.Variable_Target_Set, global.TGMS.Variable_Target_Get);
TPFuncShared(TPUser, global.TGMS.SET_TPUser, global.TGMS.GET_TPUser);
TPFuncShared(TPPath, global.TGMS.SET_TPPath, global.TGMS.GET_TPPath);
TPFuncSharedNormal(TPCol, global.TGMS.SET_TPCol);
	
	
	
	
	
	
	
	
