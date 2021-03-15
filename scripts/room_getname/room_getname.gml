/// @param room
function room_getname(){
	var Room = argument0;
	
	switch (Room) {
		default:
			return "--";
			break;
		case room_overworldtest:
			return "Overworld Test Room";
			break;
	}
}