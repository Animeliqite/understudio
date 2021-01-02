function cutscene_destroy_instance( instance ){
	with (instance)
		instance_destroy();
	
	cutscene_end_action();
}