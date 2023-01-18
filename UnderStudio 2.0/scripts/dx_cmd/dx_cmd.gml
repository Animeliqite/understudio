function dx_cmd(){
	global.dxInterpreter.registerFunction("waitFor", function (frames) {
		obj_gamehandler.dxWaitTimer = frames;
		global.dxInterpreter.pauseScene();
	});
	global.dxInterpreter.registerFunction("objectFaceTo", function (object, dir) {
		variable_instance_set(asset_get_index(object), "currDir", dir);
	});
	global.dxInterpreter.registerFunction("runIntroText", function (text) {
		if (instance_exists(obj_introhandler)) {
			with (obj_introhandler) {
				if (state == 0) {
					writer				= instance_create_depth(0, 0, 0, obj_textwriter);
					writer.text			= text + "`p3`";
					writer.voice		= [snd_alternatevoice];
					writer.textSpeed	= 1;
					writer.drawText		= false;
					writer.skippable	= false;
					global.dxInterpreter.pauseScene();
				} else throw "Intro state is not zero";
			}
		} else throw "Intro instance doesn't exist.";
	});
}