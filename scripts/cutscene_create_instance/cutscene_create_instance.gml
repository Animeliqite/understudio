function cutscene_create_instance( instance_x, instance_y, layer_id, obj){
	var inst = instance_create_layer(instance_x, instance_y, layer_id, obj);
	cutscene_end_action();
	
	return inst;
}