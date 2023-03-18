function encounter_start(object, encounterID, encounterExclamation = true, encounterAnimation = true, encounterFast = false, encounterStyle = "normal") {
	var inst = instance_create_depth(0, 0, -9999, obj_encounterhandler);
	inst.encounterObject = object;
	inst.encounterAnimation = encounterAnimation;
	inst.encounterExclamation = encounterExclamation;
	inst.encounterStyle = encounterStyle;
	inst.encounterFast = encounterFast;
}

function encounter_is_active() {
	return instance_exists(obj_encounterhandler);
}