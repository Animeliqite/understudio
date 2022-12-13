/// @param contactName
/// @param contactID
/// Adds a contact list
function call_list_add() {
	ds_list_add(obj_overworldmenu.contactNameList, argument[0]);
	ds_list_add(obj_overworldmenu.contactList, argument[1]);
}

/// @param contactID
/// Removes a contact list
function call_list_remove() {
	var menu = obj_overworldmenu;
	ds_list_delete(menu.contactList, ds_list_find_index(menu.contactList, argument[0]));
	ds_list_delete(menu.contactNameList, ds_list_find_index(menu.contactList, argument[0]));
}