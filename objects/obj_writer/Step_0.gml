/// @description Write

if (pauseTimer > 0)
	pauseTimer--;

if (pauseTimer == 0)
{
	var msg = messages[messageIndex];
	var len = string_length(msg);
	
	if (messageCharPos < len)
	{
		isDone = false;
		var faceAsset = asset_get_index(face + "_" + string(faceEmotion));
		
		if (face != noone) {
			if (faceIndex < floor(sprite_get_number(faceAsset)))
				faceIndex += 0.25;
			else
				faceIndex = 0;
		}
		
		var c = string_char_at(msg, ++messageCharPos);
		if (c == "`")
		{
			var cmdType = string_char_at(msg, ++messageCharPos);
			switch (cmdType)
			{
				case "p": // Pause
					pauseTimer = real(string_char_at(msg, ++messageCharPos)) * 10;
					messageCharPos++;
					break;
				case "i": // Instant
					messageCharPos = len;
					drawString = msg;
					messageCharPos++;
					break;
				case "#":
					messageCharPos++;
					mustBeInBounds = true;
					break;
				default:
					drawString += "`" + cmdType;
					while (messageCharPos <= len && (string_char_at(msg, messageCharPos + 1) != "`"))
						drawString += string_char_at(msg, ++messageCharPos);
					drawString += "`";
					messageCharPos++;
					break;
			}
		} else
		{	
			if (textSound != noone) && (c != " ")
			{
				for (var i = 0; i < array_length(textSound) - 1; i++)
					audio_stop_sound(textSound[i]);
				
				audio_play_sound(textSound[random_range(0, array_length(textSound) - 1)], 8, false);
			}
			
			drawString += c;
			pauseTimer = textSpeed;
		}
		
		if (global.cancel) && (skippable) {
			skip = true;
			messageCharPos = len;
			drawString = msg;
		}
	}
	else {
		isDone = true;
		faceIndex = 0;
		
		for (var i = 0; i < array_length(textSound) - 1; i++;) {
			if (audio_exists(textSound[i]))
				audio_stop_sound(textSound[i]);
		}
		
		if (global.confirm) && (confirmable) {
			if (messageIndex < array_length(messages) - 1) {
				skip = false;
				mustBeInBounds = false;
				messageIndex++;
				messageCharPos = 0;
				
				drawString = "";
			}
			else
				instance_destroy();
		}
	}
}

for (var i = 0; i < array_length(messages); i++)
	messages[i] = format_text_basic(messages[i], true, asteriskCheck);
