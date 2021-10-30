/// @description Gets all the weapons in an array.
function item_getweaponlist(){
	var weaponArray = [];
	for (var i = 0; i < ds_list_size(global.weapon); i++) {
		weaponArray[i] = ds_list_find_value(global.weapon, i);
	}
	return weaponArray;
}