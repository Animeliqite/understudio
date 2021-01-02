text_current = 0;

text[0] = "";
sprite[0] = spr_speechbubble_left_normal;

template = 0;

text_end = array_length_1d(text) - 1;

if (instance_exists(obj_targetchoice))
    instance_destroy(obj_targetchoice);

if (instance_exists(obj_target))
    obj_target.done = true;

