/// @description Set up the battle system

// Play the music
mus_loop_safe(0, battleMusic, battleVolume, battlePitch);
for (var i = 0; i < array_length(monsters); i++) {
	instance_create((room_width / 2) / ((array_length(monsters) == 2) ? (array_length(monsters) == 3 ? 2 : 1.5) : 1), global.boardY1 - 25, monsters[i]);
	with (monsters[i]) {
		monsterID = i;
		event_user(0);
	}
}