function get_message_list( jsonIndex ){
	text = [];
	textFinal = [];
	
	var n = 1;
	var o = jsonIndex + "_" + (n < 100 ? "0" : "") + (n < 10 ? "0" : "") + string(n);
	
	while (get_message(o) != "Error") {
		text[n] = get_message(o);
		array_push(textFinal, text[n]);	
		n++;
		o = jsonIndex + "_" + (n < 100 ? "0" : "") + (n < 10 ? "0" : "") + string(n);
	}
	if (get_message(o) == "Error") {
		return textFinal;
	}
}