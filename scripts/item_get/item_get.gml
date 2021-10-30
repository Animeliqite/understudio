/// @description Gets the desired item.
/// @param stateSelection
function item_get(){
	var itemIndex = argument[0];
	return ds_list_find_value(global.inv_item, itemIndex);
}