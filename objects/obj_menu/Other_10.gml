switch (string_lower(global.name)) {
	case "aaaaaa":
		nameResponse = get_message("nameResultAAAAAA");
		break;
	case "sans":
		nameResponse = get_message("nameResultSans");
		nameChooseable = false;
		break;
}