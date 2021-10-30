/// @description Sets things up for the battle sequence
/// @param monsters
/// @arg background
/// @arg music
/// @arg fleeable
function bt_set() {
	var monsters = argument[0];
	var background = 0;
	var music = "battle";
	var fleeable = true;
	
	if (argument_count > 1) {
		background = argument[1];	
		if (argument_count > 2) {
			music = argument[2];
			if (argument_count > 3) {
				fleeable = argument[3];
			}
		}
	}
	
	ds_map_set(global.battleSettings, "monsters", monsters);
	ds_map_set(global.battleSettings, "background", background);
	ds_map_set(global.battleSettings, "music", music);
	ds_map_set(global.battleSettings, "fleeable", fleeable);
}
