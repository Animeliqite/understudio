function cutscene_wait( seconds ){
	timer++;
	
	if (timer >= seconds * room_speed) {
		timer = 0;
		cutscene_end_action(); // End the cutscene
	}
}