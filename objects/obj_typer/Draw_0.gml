textX = x;
textY = y;
textColor = c_white;
siner = (current_time / 100) * 3;

for (var i = 1; i < charNo + 1; i++;) {
    siner++;
    var charAt = string_char_at(text[textNo], i);
    
    if (instant == true) && (charNo < string_length(text[textNo])) {
        charNo = string_length(text[textNo]);
        audio_stop_sound(textSound);
        
        writing = false;
    }
        
    if (textEffect != "CONNECTION") {
        if (global.cancel) && (charNo < string_length(text[textNo])) {
            charNo = string_length(text[textNo]);
            audio_stop_sound(textSound);
			
            writing = false;
        }
        
        if (global.confirm) && (charNo >= string_length(text[textNo])) && (skippableZ == true) {
            if (textNo >= array_length_1d(text) - 1) {
                typerStatus = "DESTROY";
                writing = false;
            }
            else {
                writing = true;
                
                textNo++;
                i = 1;
                charNo = 1;
                
                alarm[0] = textSpeed;
            }
        }
    }
    
    if (textEffect == "CONNECTION") && (charNo >= string_length(text[textNo])) && (skippableZ == true) {
        if (alarm[1] < 0)
            alarm[1] = 30;
    }
    
    if (charAt == "#") {    
        textY += textHeight;
        textX = x;
        
        continue;
    }
    if (charAt == "^") && (string_char_at(text[textNo], i + 1) != "0") {
        i++;        
        continue;
    }
    if (charAt == "\\") {
        if (string_char_at(text[textNo], i + 1) == "F") {
            if (string_char_at(text[textNo], i + 2) == "0") {
                face = undefined;
            }
            if (string_char_at(text[textNo], i + 2) == "1") {
                face = obj_face_undyne;
            }
            if (string_char_at(text[textNo], i + 2) == "2") {
                face = obj_face_sans;
            }
            if (string_char_at(text[textNo], i + 2) == "3") {
                face = obj_face_papyrus;
            }
            i += 2;
        }
        if (string_char_at(text[textNo], i + 1) == "C") {
            if (string_char_at(text[textNo], i + 2) == "w") {
                textColor = c_white;
            }
            if (string_char_at(text[textNo], i + 2) == "y") {
                textColor = c_yellow;
            }
            if (string_char_at(text[textNo], i + 2) == "r") {
                textColor = c_red;
            }
            if (string_char_at(text[textNo], i + 2) == "b") {
                textColor = c_blue;
            }
            if (string_char_at(text[textNo], i + 2) == "x") {
                textColor = c_black;
            }
            i += 2;
        }
        if (string_char_at(text[textNo], i + 1) == "E") {
            if (string_char_at(text[textNo], i + 2) == "0") {
                face.faceEmotion = 0; // X Face Emotion 0
            }
            if (string_char_at(text[textNo], i + 2) == "1") {
                face.faceEmotion = 1; // X Face Emotion 1
            }
            if (string_char_at(text[textNo], i + 2) == "2") {
                face.faceEmotion = 2; // X Face Emotion 2
            }
            if (string_char_at(text[textNo], i + 2) == "3") {
                face.faceEmotion = 3; // X Face Emotion 3
            }
            if (string_char_at(text[textNo], i + 2) == "4") {
                face.faceEmotion = 4; // X Face Emotion 4
            }
            if (string_char_at(text[textNo], i + 2) == "5") {
                face.faceEmotion = 5; // X Face Emotion 5
            }
            if (string_char_at(text[textNo], i + 2) == "6") {
                face.faceEmotion = 6; // X Face Emotion 6
            }
            if (string_char_at(text[textNo], i + 2) == "7") {
                face.faceEmotion = 7; // X Face Emotion 7
            }
            if (string_char_at(text[textNo], i + 2) == "8") {
                face.faceEmotion = 8; // X Face Emotion 8
            }
            if (string_char_at(text[textNo], i + 2) == "9") {
                face.faceEmotion = 9; // X Face Emotion 9
            }
            
            i += 2;
        }
        if (string_char_at(text[textNo], i + 1) == "T") {
            if (string_char_at(text[textNo], i + 2) == "0") {
                textFont = fnt_dialogue;
                textSound = snd_text_default;
                textWidth = 8;
                textHeight = 18;
                textSpeed = 1;
                textEffect = "NONE";
            }
            if (string_char_at(text[textNo], i + 2) == "1") {
                textFont = fnt_dialogue;
                textSound = snd_text_undyne;
                textWidth = 8;
                textHeight = 18;
                textSpeed = 1;
                textEffect = "NONE";
            }
            if (string_char_at(text[textNo], i + 2) == "2") {
                textFont = fnt_dialogue;
                textSound = snd_text_flowey;
                textWidth = 8;
                textHeight = 18;
                textSpeed = 1;
                textEffect = "NONE";
            }
            if (string_char_at(text[textNo], i + 2) == "3") {
                textFont = fnt_papyrus;
                textSound = snd_text_papyrus;
                textWidth = 11;
                textHeight = 18;
                textSpeed = 1;
                textEffect = "NONE";
            }
            if (string_char_at(text[textNo], i + 2) == "4") {
                textFont = fnt_comicsans;
                textSound = snd_text_sans;
                textWidth = 8;
                textHeight = 18;
                textSpeed = 2;
                textEffect = "NONE";
            }
            if (string_char_at(text[textNo], i + 2) == "5") {
                textFont = fnt_dialogue_24;
                textSound = snd_text_battle;
                textWidth = 16;
                textHeight = 36;
                textSpeed = 1;
                textEffect = "BATTLE";
            }
            if (string_char_at(text[textNo], i + 2) == "6") {
                textFont = fnt_speech;
                textSound = snd_text_default;
                textWidth = 8;
                textHeight = 18;
                textSpeed = 1;
                textColor = c_black;
                textEffect = "WAVY";
            }
            if (string_char_at(text[textNo], i + 2) == "7") {
                textFont = fnt_dialogue_24;
                textSound = snd_text_default;
                textWidth = 16;
                textHeight = 36;
                textSpeed = 1;
                textColor = c_white;
                textEffect = "NONE";
            }
            if (string_char_at(text[textNo], i + 2) == "8") {
                textFont = fnt_dialogue_24;
                textSound = snd_text_asgore;
                textWidth = 18;
                textHeight = 38;
                textSpeed = 2;
                textColor = c_white;
                textEffect = "NONE";
            }
            
            i += 2;
        }
        
        continue;
    }
    
    draw_set_color(textColor);
    draw_set_font(textFont);
    
    if (face != undefined) {
        if (textEffect == "NONE")
            draw_text(textX + 60, textY, string_hash_to_newline(string_copy(text[textNo], i, 1)));
        if (textEffect == "SHAKY")
            draw_text(textX + 60 + random_range(xstart - 0.5, xstart + 0.5), textY + random_range(ystart - 0.5, ystart + 0.5), string_hash_to_newline(string_copy(text[textNo], i, 1)));
        if (textEffect == "CONNECTION") {
           draw_text_outlined(textX + 60, textY, string_copy(text[textNo], i, 1), textColor, textAlpha, c_white, outlineAlpha);
        }
        if (textEffect == "BATTLE") {
            randomize();
            chances = irandom(500);
            if (chances > 495) {
                draw_text(textX + 120 + random_range(0.5, 0.5), textY + random_range(0.5, 0.5), string_hash_to_newline(string_copy(text[textNo], i, 1)));
            }
            else {
                draw_text(textX + 120, textY, string_hash_to_newline(string_copy(text[textNo], i, 1)));
            }
        }
    }
    else {
        if (textEffect == "NONE")
            draw_text(textX, textY, string_hash_to_newline(string_copy(text[textNo], i, 1)));
        if (textEffect == "SHAKY")
            draw_text(textX + random_range(xstart - 0.5, xstart + 0.5), textY + random_range(ystart - 0.5, ystart + 0.5), string_hash_to_newline(string_copy(text[textNo], i, 1)));
        if (textEffect == "WAVY")
            draw_text(textX + cos(siner / 3) * 1.5, textY + sin(siner / 3) * 1.5, string_hash_to_newline(string_copy(text[textNo], i, 1)));
        if (textEffect == "BATTLE") {
            randomize();
            chances = irandom(500);
            if (chances > 495) {
                draw_text(textX + random_range(0.5, 0.5), textY + random_range(0.5, 0.5), string_hash_to_newline(string_copy(text[textNo], i, 1)));
            }
            else {
                draw_text(textX, textY, string_hash_to_newline(string_copy(text[textNo], i, 1)));
            }
        }
        if (textEffect == "CONNECTION") {
           draw_text_outlined(textX, textY, string_copy(text[textNo], i, 1), textColor, textAlpha, c_white, outlineAlpha);
        }
    }
    
    textX += textWidth;
    
    if (textFont == fnt_papyrus) {
        if (string_char_at(text[textNo], i) == "D")
            textX += 1;
        if (string_char_at(text[textNo], i) == "Q")
            textX += 3;
        if (string_char_at(text[textNo], i) == "M")
            textX += 1;
        if (string_char_at(text[textNo], i) == "L")
            textX -= 1;
        if (string_char_at(text[textNo], i) == "K")
            textX -= 1;
        if (string_char_at(text[textNo], i) == "C")
            textX += 1;
        if (string_char_at(text[textNo], i) == ".")
            textX -= 3;
        if (string_char_at(text[textNo], i) == "!")
            textX -= 3;
        if string_char_at(text[textNo], i) == "O" || (string_char_at(text[textNo], i) == "W")
            textX += 2;
        if (string_char_at(text[textNo], i) == "I")
            textX -= 6;
        if (string_char_at(text[textNo], i) == "T")
            textX -= 1;
        if (string_char_at(text[textNo], i) == "P")
            textX -= 2;
        if (string_char_at(text[textNo], i) == "R")
            textX -= 2;
        if (string_char_at(text[textNo], i) == "A")
            textX += 1;
        if (string_char_at(text[textNo], i) == "H")
            textX += 1;
        if (string_char_at(text[textNo], i) == "B")
            textX += 1;
        if (string_char_at(text[textNo], i) == "G")
            textX += 1;
        if (string_char_at(text[textNo], i) == "F")
            textX -= 1;
        if (string_char_at(text[textNo], i) == "?")
            textX -= 3;
        if (string_char_at(text[textNo], i) == "'")
            textX -= 6;
        if (string_char_at(text[textNo], i) == "J")
            textX -= 1;
    }
}

if (face != undefined) {
    instance_create(x, y, face);
    
    if (room == room_battle) {
        face.image_xscale = 2;
        face.image_yscale = 2;
    }
}
if (textAlpha == 1) {
    siner++;
    
    outlineAlpha = sin(siner / 32) / 2;
}
draw_set_alpha(1);

