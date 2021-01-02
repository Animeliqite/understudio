introString = "* Test Monster draws near!";
rndString[0] = "* Test Monster is awaiting#  for your response.";
rndString[1] = "* Test Monster is looking#  at you.";
rndString[2] = "* Test Monster is just...^1 #  staying here.";

normalSprite[0] = spr_testmonster_battle;
normalSprite[1] = -1;
normalSprite[2] = -1;

hurtSprite[0] = spr_testmonster_battle_hurt;
hurtSprite[1] = -1;
hurtSprite[2] = -1;

hurtsound[0] = snd_damage_dog;
hurtsound[1] = -1;
hurtsound[2] = -1;

monstername[0] = "Test Monster";
monstername[1] = "";
monstername[2] = "";

body[0] = instance_create(room_width / 2, room_height / 2 - 100, obj_testmonster_body);
body[1] = -1;
body[2] = -1;

monsterhp[0] = 120;
monsterhp[1] = -1;
monsterhp[2] = -1;

monsterhpmax[0] = 120;
monsterhpmax[1] = -1;
monsterhpmax[2] = -1;

text[0,0] = "Halt,^1 human!^1 #Listen to me...";
text[0,1] = "You'll have to defeat#me first.";
text[0,2] = "I won't let you pass!";
text[0,3] = "...and you really#gotta try to defeat#me to pass.";
text[0,4] = "Anyways,^1 #you do you.^1 #(Except passing.)";
text[0,5] = "...";

textPhase[0] = 0;
textPhase[1] = -1;
textPhase[2] = -1;

text[1,0] = "";
text[2,0] = "";

