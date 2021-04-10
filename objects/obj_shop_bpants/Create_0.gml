event_inherited();

global.currentsong = "shop";

mus_loop_safe(0, global.currentsong, vol, 0.7);

faceNo = 0;

introString = "* Welcome to MTT-Brand#  Burger Emporium,^1 home#  of the Glamburger.^1#* Sparkle up your#  day (TM).";
exitString = "* Any time,^1 little buddy.";
talkString = "* I'm sorry,^1 (Ha ha) it's against#  the rules to talk to customers#  who haven't bought anything.";
talkMenuText = "Take it#from me,^1#little#buddy.";

talkOption[0] = "Life Advice";
talkOption[1] = "Glamburger Story";
talkOption[2] = "Why else is MTT bad";
talkOption[3] = "Your future";

talkOptionNew[0] = false;
talkOptionNew[1] = false;
talkOptionNew[2] = false;
talkOptionNew[3] = false;

canTalk = true;

typer = "DEFAULT";

exitRoom = room_overworldtest;
exitSpawn = 1;

drawHands = false;
drawSmoke = false;

create_text(0, 110, "DEFAULT", c_white, introString, false);

