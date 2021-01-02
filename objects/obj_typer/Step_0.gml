if (typerStatus == "DESTROY") {
    if (textEffect != "CONNECTION") {
        if (face != undefined) {
            instance_destroy(face);
        }
        face = undefined;
        faceEmotion = 0;
        
        if (instance_exists(obj_dialogue))
            instance_destroy(obj_dialogue);
        instance_destroy();
    }
    else {
         if (alarm[2] < 0)
            alarm[2] = 30;
    }
}

