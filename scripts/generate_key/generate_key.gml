function generate_key(){
	var generated_key = "";
	
	randomize();
	repeat (32) {
		generated_key += chr(choose(random_range(65, 90), random_range(97, 122)));
	}
	
	return generated_key;
}