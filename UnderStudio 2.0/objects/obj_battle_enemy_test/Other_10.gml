/// @description Enemy Events

var _obj = id;
var bt = obj_battlehandler;

switch (enemyEvent) {
	case ENEMY_EVENT.PLAYER_FIGHT:
		instance_create_depth(0, 0, -2000, global.battleFightTargetObj);
		break;
	case ENEMY_EVENT.ENEMY_DAMAGE:
		var dmg_taken = battle_calculate_dmg(bt.damage_accuracy);
		sprite_index = _obj.enemyHurtSprite;
		
		shake_object(id, 16, 0, false, false, 1, 1);
		with (instance_create_depth(x, y - (sprite_height / 2), -2000, obj_battledmghandler)) {
			barWidth = 140;
			dmgAmount = dmg_taken;
			hpOld = _obj.enemyHP;
		}
		
		sfx_play(snd_battle_enemy_hurt);
		enemyHP -= dmg_taken;
		break;
	case ENEMY_EVENT.ENEMY_DAMAGE_AFTERMATH:
		sprite_index = _obj.enemyIdleSprite;
		
		if (enemyHP < 0) {
			sfx_play(snd_battle_enemy_vaporize);
			battle_remove_enemy(battle_get_selected_enemy());
			battle_accumulate_rewards(enemyXP, enemyGold);
			
			with (instance_create_depth(x, y, depth, obj_battlevaporhandler)) {
				sprite = _obj.enemyHurtSprite;
				xscale = 2;
				yscale = 2;
			}
			
			instance_destroy();
		}
		break;
	case ENEMY_EVENT.TURN_PREPARATION:
		battle_create_speechbubble(x + 80, y - 180, "Test#message!", 200, 80);
		
		obj_battleboardhandler.updatePosition(320, 320, 120, 50);
		break;
}