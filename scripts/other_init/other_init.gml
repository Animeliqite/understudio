/// @description Initializes other variables.
function other_init(){
	enum text_effect {
		none,
		shake,
		partly_shake,
		wave
	}
	
	enum battle_menu {
		button,
		monster_selection,
		fight_target,
		fight_attack,
		act_action,
		item,
		mercy
	}
	
	enum battle_index {
		button,
		monster_selection,
		fight,
		act,
		item,
		mercy
	}
	
	exception_unhandled_handler(function(ex) {
		show_message("The game has unexpectedly crashed. Please contact the developers.\nMore info:\n" + string(ex.longMessage));
	    if file_exists("crash.txt") file_delete("crash.txt");
	    var f = file_text_open_write("crash.txt");
	    file_text_write_string(f, string(ex));
	    file_text_close(f);
	});
	
	#macro game_savename "undertale_engine"
	#macro game_name "Undertale Engine"
	#macro game_version "1.00"
	#macro game_owner "Animelici804"
}