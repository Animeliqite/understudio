/// @description  create_text_instant(textX, textY, typer, color, string);
/// @param textX
/// @param  textY
/// @param  typer
/// @param  color
/// @param  string
function create_text_instant(argument0, argument1, argument2, argument3, argument4) {

	var xx = argument0;
	var yy = argument1;

	var typer = argument2;
	var color = argument3;

	var String = argument4;

	switch (typer) {
	    case 0:
	    case "DEFAULT":
	        prefix = "";
	        break;
	    case 1:
	    case "UNDYNE":
	        prefix = "\\T1\\F1";
	        break;
	    case 2:
	    case "SANS":
	        prefix = "\\T4\\F2";
	        break;
	    case 3:
	    case "PAPYRUS":
	        prefix = "\\T3\\F3";
	        break;
	    case 4:
	    case "DEFAULT-BATTLE":
	        prefix = "\\T5";
	        break;
	}

	var w = instance_create(xx + 20, yy + 20, obj_typer);
	w.text[0] = prefix + String;
	w.textColor = color;
	w.instant = true;
	w.skippableZ = false;



}
