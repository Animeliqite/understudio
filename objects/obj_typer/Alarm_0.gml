with (other) {
var charAt = string_char_at(text[textNo], charNo);
var delay = 0;


if (charNo < string_length(text[textNo])) {
    charNo++;
    
    alarm[0] = textSpeed;
    
    if (face != undefined) {
        if (instance_exists(face))
            face.image_speed = 0.2;
    }
    
    writing = true;
}
else {
    writing = false;
	
    audio_stop_sound(textSound);
    
	if (face != undefined) {
        if (instance_exists(face)) {
            face.image_speed = 0;
            face.image_index = 0;
        }
    }
}

if (string_char_at(text[textNo], charNo) == "^") {
    charNo++;
    if (string_char_at(text[textNo], charNo) != "0") {
        n = real(string_char_at(text[textNo], charNo));
        alarm[0] = n * 10;
    }
}

if (textEffect != "CONNECTION") && (instant == false) {
    if (charAt != "#") && (charAt != " ") && (charAt != "\\") && (charAt != "^") {
        audio_stop_sound(textSound);
        audio_play_sound(textSound, 10, false);
    }
}

}
