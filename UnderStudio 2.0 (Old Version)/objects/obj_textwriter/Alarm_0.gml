/// @description Format Text

if (!formatText) exit;
for (var i = 0; i < array_length(punctuations); i++)
	text = string_replace_all(text, punctuations[i], punctuations[i] + "`p1`");