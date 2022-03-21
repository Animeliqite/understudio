/// @description Initialize

state				= 0;
subState			= 0;
selection			= 0;
prevSelection		= undefined;

namingHeader		= "Name the fallen human."
namingLetters		= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

musManager			= new MusicManager();
musicFile			= musManager.Load("menu0");
menuMusic			= musManager.Play(musicFile, 1, 1);