/// @param itemPos
/// Gets the item ID from an item position
function item_get_id() {
	return ds_list_find_value(global.playerInventory, argument[0]);
}
	
/// @param itemID
/// Adds an item to the inventory
function item_add() {
	ds_list_add(global.playerInventory, argument[0]);
}
	
/// @param itemPos
/// Removes an item from the inventory
function item_remove() {
	ds_list_delete(global.playerInventory, argument[0]);
}
	
/// @param itemID
/// Gets the name of an item
function item_get_name() {
	switch (argument[0]) {
		default: return "Nothing"; break;
		case ITEM.MONSTER_CANDY: return "Monster Candy"; break;
		case ITEM.BUTTERSCOTCH_PIE: return "Butterscotch Pie"; break;
	}
}

/// @param itemID
/// Gets the info of an item
function item_get_info() {
	switch (argument[0]) {
		default: return {hp : 0, special : false, price : 0, keyName : undefined}; break;
		case ITEM.MONSTER_CANDY: return {hp : 10, special : false, price : 3, keyName : "monstercandy"}; break;
		case ITEM.BUTTERSCOTCH_PIE: return {hp : 100, special : false, price : 10, keyName : "butterscotch_pie"}; break;
	}
}

/// @param weaponID
/// Sets the weapon to the inventory
function weapon_set() {
	global.playerWeapon = argument[0];
}

/// @param weaponID
/// Removes a weapon from the inventory
function weapon_remove() {
	global.playerWeapon = undefined;
}
	
/// @param weaponID
/// Gets the name of a weapon
function weapon_get_name() {
	switch (argument[0]) {
		default: return "Nothing"; break;
		case WEAPON.STICK: return "Stick"; break;
		case WEAPON.TOY_KNIFE: return "Toy Knife"; break;
	}
}

/// @param weaponID
/// Gets the info of a weapon
function weapon_get_info() {
	switch (argument[0]) {
		default: return {strength : 0, price : 0, keyName : undefined}; break;
		case WEAPON.STICK: return {strength : 0, price : 3, keyName : "stick"}; break;
		case WEAPON.TOY_KNIFE: return {strength : 2, price : 5, keyName : "toyknife"}; break;
	}
}

/// @param armorID
/// Sets the weapon to the inventory
function armor_set() {
	global.playerArmor = argument[0];
}

/// @param armorID
/// Removes a weapon from the inventory
function armor_remove() {
	global.playerArmor = undefined;
}

/// @param weaponID
/// Gets the name of a weapon
function armor_get_name() {
	switch (argument[0]) {
		default: return "Nothing"; break;
		case ARMOR.BANDAGE: return "Bandage"; break;
		case ARMOR.FADED_RIBBON: return "Faded Ribbon"; break;
	}
}

/// @param weaponID
/// Gets the info of a weapon
function armor_get_info() {
	switch (argument[0]) {
		default: return {strength : 0, price : 0, keyName : undefined}; break;
		case ARMOR.BANDAGE: return {strength : 0, price : 3, keyName : "stick"}; break;
		case ARMOR.FADED_RIBBON: return {strength : 2, price : 5, keyName : "toyknife"}; break;
	}
}
