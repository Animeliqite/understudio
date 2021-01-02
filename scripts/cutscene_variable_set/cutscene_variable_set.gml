function cutscene_variable_set( instance, new_variable_as_string, new_variable_value ) {
	variable_instance_set(instance, new_variable_as_string, new_variable_value);
	cutscene_end_action();
}