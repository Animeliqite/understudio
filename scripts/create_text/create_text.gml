/// @description  create_text(textX, textY, typer, color, string, skippableZ);
/// @param textX
/// @param  textY
/// @param  typer
/// @param  color
/// @param  string
/// @param  skippableZ
function create_text(argument0, argument1, argument2, argument3, argument4, argument5) {

	var xx = argument0;
	var yy = argument1;

	var typer = argument2;
	var color = argument3;

	var String = argument4;

	var skippable = argument5;

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
	    case 5:
	    case "SPEECH":
	        prefix = "\\T6";
	        break;
	}

	var w = instance_create(xx + 20, yy + 20, obj_typer);
	w.text[0] = prefix + String;
	w.textColor = color;
	w.skippableZ = skippable;



}
