/// @description Adds a new desired item but limited to 8 slots.
/// @param newItem
function item_add(){
	var newItem = argument[0];
	if (ds_list_size(global.inv_item) < 8)
		return ds_list_add(global.inv_item, newItem);
}