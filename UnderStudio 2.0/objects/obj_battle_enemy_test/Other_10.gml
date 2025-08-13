/// @description Enemy Events

var _obj = id;
switch (enemyEvent) {
	case ENEMY_EVENT.PLAYER_FIGHT:
		instance_create_depth(0, 0, -2000, global.battleFightTargetObj);
		break;
	case ENEMY_EVENT.ENEMY_DAMAGE:
		var dmg_taken = battle_calculate_dmg(_obj.damageTaken);
		sprite_index = _obj.enemyHurtSprite;
		
		shake_object(id, 16, 0, false, false, 1, 1);
		with (instance_create_depth(x, y - (sprite_height / 2), -2000, obj_battledmghandler)) {
			dmgAmount = dmg_taken;
			hpOld = _obj.enemyHP;
		};
		
		
		sfx_play(snd_battle_enemy_hurt);
		enemyHP -= dmg_taken;
		break;
	case ENEMY_EVENT.ENEMY_DAMAGE_AFTERMATH:
		sprite_index = _obj.enemyIdleSprite;
		
		if (enemyHP > 0) {
			sfx_play(snd_battle_enemy_vaporize);
			
			with (instance_create_depth(x, y, depth, obj_battlevaporhandler)) {
				sprite = _obj.enemyHurtSprite;
				xscale = 2;
				yscale = 2;
			}
			
			instance_destroy();
		}
		
		// Aftermath of this state
		timer_set(function () {
			battle_set_state(battle_get_next_state());
		}, 45, []);
		break;
	case ENEMY_EVENT.TURN_PREPARATION:
		obj_battleboardhandler.updatePosition(300, 250, 200, 50);
		break;
}