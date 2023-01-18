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

borderOffsetX = 0; // X Offset of the border
borderOffsetY = 0; // Y Offset of the border
borderWidth = 1; // Width of the border
borderHeight = 1; // Height of the border

screenOffsetX = 0; // X Offset of the screen
screenOffsetY = 0; // Y Offset of the screen
screenWidth = 1; // Width of the screen
screenHeight = 1; // Height of the screen

dxWaitTimer = 0; // Diannex wait timer
dxWaitCondition = undefined; // Diannex wait condition

game_init(); // Execute the utilization script
room_goto_next(); // Go to the next room

