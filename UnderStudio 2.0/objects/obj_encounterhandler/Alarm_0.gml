/// @description Set Heart Go To positions

heartX = encounterObject.x - obj_camerahandler.x;
heartY = encounterObject.y - obj_camerahandler.y;
encounterObject.canMove = false;

switch (encounterStyle) {
	case "normal":
		heartGoToX = 16;
		heartGoToY = 220;
		break;
	case "center":
		heartGoToX = 320;
		heartGoToY = 240;
		break;
}