/// @description Initialize

state			= 0;
subState		= 0;
selection		= 0;

namingHeader	= "Name the fallen human."
namingLetters	= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

musManager		= global.musicManager;
menuMusic		= musManager.Play(musManager.Load("menu0"), 1, 1);