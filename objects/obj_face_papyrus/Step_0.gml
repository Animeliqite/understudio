switch (faceEmotion) {
    case 0:
        sprite_index = spr_face_papyrus;
        break;
    case 1:
        sprite_index = spr_face_papyrus_mad;
        break;
    case 2:
        sprite_index = spr_face_papyrus_cool;
        break;
    case 3:
        sprite_index = spr_face_papyrus_dejected;
        break;
    case 4:
        sprite_index = spr_face_papyrus_side;
        break;
    case 5:
        sprite_index = spr_face_papyrus_cry;
        break;
}

if (obj_typer.face == undefined) {
    instance_destroy();
}

