function bt_getsettings( key ){
	if (ds_map_exists(global.battleSettings, key))
		return ds_map_find_value(global.battleSettings, key);
	else
		return undefined;
}