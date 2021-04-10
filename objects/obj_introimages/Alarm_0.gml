/// @description Initialize the story
visible = true;

text = get_message_list("story");
textNo = 1;
textEnd = array_length(text) - 1;
write = true;

event_user(0);

mus_play(0, "story", 1, 0.91);