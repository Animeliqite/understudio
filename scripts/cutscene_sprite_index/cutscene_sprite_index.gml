// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cutscene_sprite_index(instance, sprite){
	with (instance) {
		sprite_index = sprite;
	}
	
	cutscene_end_action();
}