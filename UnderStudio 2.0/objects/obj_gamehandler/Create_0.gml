/// @description Initialize everything

/*
	In here, we can change some variables to test things without having to
	go through the gameplay. Though please note that changing some could create
	multiple issues in the gameplay. Don't forget to turn debugging off when
	compiling it into an executable file!
*/

global.chapter = 0; // The current chapter
global.language = "en"; // The current language
global.debug = false; // Debug menu

game_util(); // Execute the utilization script