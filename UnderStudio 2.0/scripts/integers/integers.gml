function number_add(number, valMax, incrementAmount = 1) {
	if (number < valMax) {
		if (number - incrementAmount < incrementAmount)
			number = valMax;
		else number += incrementAmount;
	}
	
	return number;
}

function number_sub(number, valMin, decrementAmount = 1) {
	if (number > valMin) {
		if (number - decrementAmount < decrementAmount)
			number = valMin;
		else number -= decrementAmount;
	}
	
	return number;
}