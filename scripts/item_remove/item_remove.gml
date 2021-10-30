/// @description Removes a desired item.
/// @param itemID
function item_remove(){
	var itemID = argument[0];
	ds_list_delete(global.inv_item, ds_list_find_index(global.inv_item, itemID));
}