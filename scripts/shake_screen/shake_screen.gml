/// @param shake_amount
function shake_screen(){
	shake_amount = argument0;
	
	var shaker = instance_create(0, 0, obj_screenshaker);
	shaker.shake = shake_amount;
}