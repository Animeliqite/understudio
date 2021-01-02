murder = false; // Checks if the player has commited murder or not.

vol = 0.8; // The music's volume.

menuMax = 3; // Max amount of selections you can choose.
menu = 0; // The current menu number.
menuMiniY = 120; // The mini menu's Y that appears when you choose BUY.

menuSel[0] = 0;
menuSel[1] = 0;

canTalk = true;

introString = "* Welcome to my shop!";
exitString = "* Come again some time!";
talkString = "* Error!";

typer = "DEFAULT";

exitRoom = room_overworldtest;
exitSpawn = 0;

sell = false;
bought = false;
selling = false;

mainMessage = "* Error!";

talkOption[0] = "Talk No. 1";
talkOption[1] = "Talk No. 2";
talkOption[2] = "Talk No. 3";
talkOption[3] = "Very Loooooooooong Talk No. 4";

talkOptionNew[0] = false;
talkOptionNew[1] = false;
talkOptionNew[2] = false;
talkOptionNew[3] = false;

talkMenuText = "Care to#chat?";

itemCost[0] = 10;
itemCost[1] = 15;
itemCost[2] = 20;
itemCost[3] = 25;

draw_set_font(fnt_dialogue);

