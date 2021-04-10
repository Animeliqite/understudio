function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = -9999999; // obj_init
	global.__objectDepths[1] = 0; // obj_border
	global.__objectDepths[2] = 0; // input
	global.__objectDepths[3] = 0; // obj_musicer
	global.__objectDepths[4] = -999999; // obj_typer
	global.__objectDepths[5] = -999999999; // obj_persistent_fade
	global.__objectDepths[6] = -9999999; // obj_unfader
	global.__objectDepths[7] = -999999; // obj_face_parent
	global.__objectDepths[8] = -999999; // obj_face_undyne
	global.__objectDepths[9] = -999999; // obj_face_papyrus
	global.__objectDepths[10] = -999999; // obj_face_sans
	global.__objectDepths[11] = 0; // obj_doorparent
	global.__objectDepths[12] = 0; // obj_door_a
	global.__objectDepths[13] = 0; // obj_door_shop
	global.__objectDepths[14] = 0; // obj_door_b
	global.__objectDepths[15] = 0; // obj_door_c
	global.__objectDepths[16] = 0; // obj_door_d
	global.__objectDepths[17] = 0; // obj_door_e
	global.__objectDepths[18] = 0; // obj_door_f
	global.__objectDepths[19] = 0; // obj_door_w
	global.__objectDepths[20] = 0; // obj_door_x
	global.__objectDepths[21] = 0; // obj_marker_a
	global.__objectDepths[22] = 0; // obj_marker_b
	global.__objectDepths[23] = 0; // obj_marker_c
	global.__objectDepths[24] = 0; // obj_marker_d
	global.__objectDepths[25] = 0; // obj_marker_e
	global.__objectDepths[26] = 0; // obj_marker_f
	global.__objectDepths[27] = 0; // obj_marker_w
	global.__objectDepths[28] = 0; // obj_marker_x
	global.__objectDepths[29] = -10; // obj_player
	global.__objectDepths[30] = 0; // obj_solid_parent
	global.__objectDepths[31] = 0; // obj_solidsmall
	global.__objectDepths[32] = 0; // obj_slope_dl
	global.__objectDepths[33] = 0; // obj_slope_dr
	global.__objectDepths[34] = 0; // obj_slope_ul
	global.__objectDepths[35] = 0; // obj_slope_ur
	global.__objectDepths[36] = -99999; // obj_dialogue
	global.__objectDepths[37] = 0; // obj_interactable
	global.__objectDepths[38] = 0; // obj_damedane
	global.__objectDepths[39] = -500; // obj_cmenu
	global.__objectDepths[40] = 0; // obj_npc_parent
	global.__objectDepths[41] = 0; // obj_npc_template
	global.__objectDepths[42] = 0; // obj_npc_papyrus
	global.__objectDepths[43] = 0; // obj_npc_template_sign
	global.__objectDepths[44] = -999999; // obj_encnotif
	global.__objectDepths[45] = -9999999; // obj_encounter_normal
	global.__objectDepths[46] = 0; // obj_hint_encounter
	global.__objectDepths[47] = 0; // obj_fightbt
	global.__objectDepths[48] = 0; // obj_actbt
	global.__objectDepths[49] = 0; // obj_itembt
	global.__objectDepths[50] = 0; // obj_mercybt
	global.__objectDepths[51] = -999999; // obj_battleheart
	global.__objectDepths[52] = -999999; // obj_battleheart_gtfo
	global.__objectDepths[53] = 0; // obj_uborder
	global.__objectDepths[54] = 0; // obj_dborder
	global.__objectDepths[55] = 0; // obj_testmonster_battle
	global.__objectDepths[56] = 0; // obj_testmonster_body
	global.__objectDepths[57] = -999000; // obj_testmonster_spear
	global.__objectDepths[58] = 0; // obj_spareeffect
	global.__objectDepths[59] = 0; // obj_shaker
	global.__objectDepths[60] = -999999; // obj_attack_healthbar
	global.__objectDepths[61] = -999999; // obj_attack_knife
	global.__objectDepths[62] = -999998; // obj_targetchoice
	global.__objectDepths[63] = -999997; // obj_target
	global.__objectDepths[64] = -999998; // obj_speechbubble
	global.__objectDepths[65] = -99999; // obj_battlemanager
	global.__objectDepths[66] = 0; // obj_shopcontroller
	global.__objectDepths[67] = 0; // obj_shop_bpants


	global.__objectNames[0] = "obj_init";
	global.__objectNames[1] = "obj_border";
	global.__objectNames[2] = "input";
	global.__objectNames[3] = "obj_musicer";
	global.__objectNames[4] = "obj_typer";
	global.__objectNames[5] = "obj_persistent_fade";
	global.__objectNames[6] = "obj_unfader";
	global.__objectNames[7] = "obj_face_parent";
	global.__objectNames[8] = "obj_face_undyne";
	global.__objectNames[9] = "obj_face_papyrus";
	global.__objectNames[10] = "obj_face_sans";
	global.__objectNames[11] = "obj_doorparent";
	global.__objectNames[12] = "obj_door_a";
	global.__objectNames[13] = "obj_door_shop";
	global.__objectNames[14] = "obj_door_b";
	global.__objectNames[15] = "obj_door_c";
	global.__objectNames[16] = "obj_door_d";
	global.__objectNames[17] = "obj_door_e";
	global.__objectNames[18] = "obj_door_f";
	global.__objectNames[19] = "obj_door_w";
	global.__objectNames[20] = "obj_door_x";
	global.__objectNames[21] = "obj_marker_a";
	global.__objectNames[22] = "obj_marker_b";
	global.__objectNames[23] = "obj_marker_c";
	global.__objectNames[24] = "obj_marker_d";
	global.__objectNames[25] = "obj_marker_e";
	global.__objectNames[26] = "obj_marker_f";
	global.__objectNames[27] = "obj_marker_w";
	global.__objectNames[28] = "obj_marker_x";
	global.__objectNames[29] = "obj_player";
	global.__objectNames[30] = "obj_solid_parent";
	global.__objectNames[31] = "obj_solidsmall";
	global.__objectNames[32] = "obj_slope_dl";
	global.__objectNames[33] = "obj_slope_dr";
	global.__objectNames[34] = "obj_slope_ul";
	global.__objectNames[35] = "obj_slope_ur";
	global.__objectNames[36] = "obj_dialogue";
	global.__objectNames[37] = "obj_interactable";
	global.__objectNames[38] = "obj_damedane";
	global.__objectNames[39] = "obj_cmenu";
	global.__objectNames[40] = "obj_npc_parent";
	global.__objectNames[41] = "obj_npc_template";
	global.__objectNames[42] = "obj_npc_papyrus";
	global.__objectNames[43] = "obj_npc_template_sign";
	global.__objectNames[44] = "obj_encnotif";
	global.__objectNames[45] = "obj_encounter_normal";
	global.__objectNames[46] = "obj_hint_encounter";
	global.__objectNames[47] = "obj_fightbt";
	global.__objectNames[48] = "obj_actbt";
	global.__objectNames[49] = "obj_itembt";
	global.__objectNames[50] = "obj_mercybt";
	global.__objectNames[51] = "obj_battleheart";
	global.__objectNames[52] = "obj_battleheart_gtfo";
	global.__objectNames[53] = "obj_uborder";
	global.__objectNames[54] = "obj_dborder";
	global.__objectNames[55] = "obj_testmonster_battle";
	global.__objectNames[56] = "obj_testmonster_body";
	global.__objectNames[57] = "obj_testmonster_spear";
	global.__objectNames[58] = "obj_spareeffect";
	global.__objectNames[59] = "obj_shaker";
	global.__objectNames[60] = "obj_attack_healthbar";
	global.__objectNames[61] = "obj_attack_knife";
	global.__objectNames[62] = "obj_targetchoice";
	global.__objectNames[63] = "obj_target";
	global.__objectNames[64] = "obj_speechbubble";
	global.__objectNames[65] = "obj_battlemanager";
	global.__objectNames[66] = "obj_shopcontroller";
	global.__objectNames[67] = "obj_shop_bpants";


	// create another array that has the correct entries
	var len = array_length(global.__objectDepths);
	global.__objectID2Depth = [];
	for( var i=0; i<len; ++i ) {
		var objID = asset_get_index( global.__objectNames[i] );
		if (objID >= 0) {
			global.__objectID2Depth[ objID ] = global.__objectDepths[i];
		} // end if
	} // end for


}
