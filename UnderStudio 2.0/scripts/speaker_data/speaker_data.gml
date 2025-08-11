function DialogueSpeaker() constructor {
	global.speakerList = ds_map_create();
	
	static AddSpeaker = function (key, name, voice, face, font = fnt_main, npc = noone) {
		ds_map_set(global.speakerList, key, {
			Name: name,
			Voice: voice,
			Face: face,
			Font: font,
			Npc: npc
		});
	}
	
	static RemoveSpeaker = function (key) {
		ds_map_delete(global.speakerList, key);
	}
	
	static GetSpeakerData = function (key, variable) {
		var _data = ds_map_find_value(global.speakerList, key);
		return struct_get(_data, variable);
	}
}

function speaker_init() {
	global.speakers = new DialogueSpeaker();
	
	// Default speaker
	global.speakers.AddSpeaker(
		"none",
		"",
		[snd_defaultvoice],
		undefined,
	);
	
	// Alternate speaker (Battle)
	global.speakers.AddSpeaker(
		"none_alt",
		"",
		[snd_alternatevoice],
		undefined,
	);
}