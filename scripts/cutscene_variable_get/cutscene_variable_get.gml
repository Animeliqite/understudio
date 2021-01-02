function cutscene_variable_get( instance, variable_as_string ) {
	variable_instance_get(instance, variable_as_string);
	cutscene_end_action();
}