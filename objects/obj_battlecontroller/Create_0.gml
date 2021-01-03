/// @description Initialize the variables

#region -- MENU SYSTEM --

sel[0] = 0; // Selection
sel[1] = 0; // Fight
sel[2] = 0; // Act
sel[3] = 0; // Item
sel[4] = 0; // Mercy

menuno = 0;
fleeable = true;
spareable = true;

#endregion

#region -- ACT SYSTEM --
for (var i = 0; i < 6; i++;) {
	actName[i] = "Smooch";
}
#endregion

#region -- BOX SYSTEM --

box_id_prev = global.boxplacement;
turn_time = 180;
ready = false;

#endregion

#region -- AT THE BATTLE END --

goldReward = irandom(5);
xpReward = irandom(3);
chance = irandom(100); // For fleeing
cooldown = 0;

#endregion

#region -- OTHER THINGS --

wroteIntroString = false;

#endregion

#region -- MUSIC SYSTEM --

global.currentsong = mus_battle1;
instance_create(0, 0, obj_unfader);

#endregion