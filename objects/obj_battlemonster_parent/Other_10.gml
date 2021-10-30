/// @description At Battle Start

// Set the statistics of the monster
bt_setmonstername(monsterID, "Test Monster");
bt_setmonsterstats(monsterID, 0, 0);
bt_setmonsteracts(monsterID, ["Check"]);
bt_setmonsteractresult(monsterID, 0, "* The monster for testing&  purposes.");
bt_setmonsterhp(monsterID, 50, 50);

image_speed = 0.2;
image_xscale = 2;
image_yscale = 2;
y -= 80;