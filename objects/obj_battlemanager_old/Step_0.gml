/// @description Battle Control

#region -- IN ENEMY'S TURN --

/// Menu No. -2
if (state == -2) {
    if (turn_time > 0)
        turn_time--;
    else
        bt_setstate(-1);
    
    if (ready == false) && (global.monster.monsterhp[sel[1]] > 0) {
        with (global.monster) {
            event_user(2);
        }
        
        ready = true;
    }
	else if (ready == false) && (global.monster.monsterhp[sel[1]] <= 0) {
		state = 10000;
		
		ready = true;
	}
}

#endregion

#region -- IN ENEMY TURN'S END --

if (state == -1) {
    instance_destroy(obj_typer);
    
    if (instance_exists(obj_targetchoice))
        instance_destroy(obj_targetchoice);
    
    if (instance_exists(obj_target))
        obj_target.done = true;
    
    scr_setbox(0);
    
    obj_battleheart.moveable = false;
    obj_battleheart.x = -9999;
    obj_battleheart.y = -9999;
    
    cooldown = 3;
}

#endregion

#region -- AT THE SELECTION --

if (instance_exists(global.monster)) {
	if (cooldown > 0)
        cooldown--;
    
    if (state == 0) {
        if (!instance_exists(obj_typer)) && (wroteIntroString == false)
            create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, global.monster.introString, false);
        
        if (!instance_exists(obj_typer)) && (wroteIntroString == true)
            create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, global.monster.rndString[irandom(array_length(global.monster.rndString) - 1)], false);
        
        wroteIntroString = true;
        
        if (global.left_press) {
            if (sel[0] > 0)
                sel[0]--;
            else
                sel[0] = 3;
            
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.right_press) {
            if (sel[0] < 3)
                sel[0]++;
            else
                sel[0] = 0;
            
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.confirm) && (cooldown == 0) {
            if (sel[0] == 0) {
                state = 1;
                sel[1] = 0;
                
                cooldown = 3;
            }
            if (sel[0] == 1)
                state = 2;
            if (sel[0] == 2)
                state = 3;
            if (sel[0] == 3) {
                state = 4;
                sel[4] = 0;
            }
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
            
            cooldown = 3;
        }
        
        switch (sel[0]) {
            case 0:
                obj_battleheart.x = 40;
                obj_battleheart.y = 446;
                break;
            case 1:
                obj_battleheart.x = 193;
                obj_battleheart.y = 446;
                break;
            case 2:
                obj_battleheart.x = 353;
                obj_battleheart.y = 446;
                break;
            case 3:
                obj_battleheart.x = 508;
                obj_battleheart.y = 446;
                break;
        }
    }
}

#endregion

#region -- AT FIGHT --

if (instance_exists(global.monster)) {
    if (state == 1) {
        instance_destroy(obj_typer);
		
        obj_battleheart.x = -9999;
        obj_battleheart.y = -9999;
        
        if (!instance_exists(obj_typer)) {
            if (global.monster.monstername[2] != "")
                create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "   * " + global.monster.monstername[0] + "#   * " + global.monster.monstername[1] + "#   * " + global.monster.monstername[2]);
            if (global.monster.monstername[1] != "")
                create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "   * " + global.monster.monstername[0] + "#   * " + global.monster.monstername[1]);
            if (global.monster.monstername[0] != "")
                create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "   * " + global.monster.monstername[0]);
            
        }
        if (global.up_press) {
            if (sel[1] > 0)
                sel[1]--;
            else {
                if (global.monster.monstername[2] != "") {
                    sel[1] = 2;
                    
                    audio_play_sound(snd_menuswitch, 10, false);
                }
                else if (global.monster.monstername[1] != "") {
                    sel[1] = 1;
                    
                    audio_play_sound(snd_menuswitch, 10, false);
                }
                else if (global.monster.monstername[0] != "")
                    sel[1] = 0;
            }
        }
        if (global.down_press) {
            if (global.monster.monstername[2] != "") {
                if (sel[1] < 2)
                    sel[1]++;
                else
                    sel[1] = 0;
                
                audio_play_sound(snd_menuswitch, 10, false);
            }
            else if (global.monster.monstername[2] != "") {
                if (sel[1] < 1)
                    sel[1]++;
                else
                    sel[1] = 0;
                
                audio_play_sound(snd_menuswitch, 10, false);
            }
            else if (global.monster.monstername[1] == "") {
                sel[1] = 0;
            }
        }
        
        obj_battleheart.x = obj_uborder.x + 30;
        obj_battleheart.y = obj_uborder.y + 30 + (sel[1] * 35);
        
        if (global.confirm) && (cooldown == 0) {
            if (sel[1] == 0) {
                show_debug_message("sel[1] is selected!");
                
                with (global.monster) {
                    event_user(0);
                }
                
                bt_setstate(-999);
                instance_destroy(obj_typer);
            }
            if (sel[1] == 1)
                show_debug_message("sel[1] is selected!");
                
                with (global.monster) {
                    event_user(0);
                }
                
                bt_setstate(-999);
                instance_destroy(obj_typer);
            if (sel[1] == 2)
                show_debug_message("sel[1] is selected!");
                
                with (global.monster) {
                    event_user(0);
                }
                
                bt_setstate(-999);
                instance_destroy(obj_typer);
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
        }
        
        if (global.cancel) {
            state = 0;
            instance_destroy(obj_typer);
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
        }
    }
}

#endregion

#region -- AT ACT --

if (instance_exists(global.monster)) {
    if (state == 2) {
        instance_destroy(obj_typer);
        
        obj_battleheart.x = -9999;
        obj_battleheart.y = -9999;
        
        /*if (!instance_exists(obj_typer)) && (wroteIntroString == false)
            create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, global.monster.introString, false);
        
        if (!instance_exists(obj_typer)) && (wroteIntroString == true)
                create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, global.monster.rndString[irandom(array_length(global.monster.rndString) - 1)], false);
        
        wroteIntroString = true;
        
        if (global.left_press) {
            if (sel[0] > 0)
                sel[0]--;
            else
                sel[0] = 3;
            
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.right_press) {
            if (sel[0] < 3)
                sel[0]++;
            else
                sel[0] = 0;
            
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.confirm) {
            if (sel[1] == 0)
                state = 1;
            if (sel[1] == 1)
                state = 2;
            if (sel[1] == 2)
                state = 3;
            if (sel[1] == 3)
                state = 4;
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
        }*/
        
        if (global.cancel) {
            state = 0;
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
        }
    }
}

#endregion

#region -- AT ITEM --

if (instance_exists(global.monster)) {
    if (state == 3) {
        instance_destroy(obj_typer);
        
        obj_battleheart.x = -9999;
        obj_battleheart.y = -9999;
        
        /*if (!instance_exists(obj_typer)) && (wroteIntroString == false)
            create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, global.monster.introString, false);
        
        if (!instance_exists(obj_typer)) && (wroteIntroString == true)
                create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, global.monster.rndString[irandom(array_length(global.monster.rndString) - 1)], false);
        
        wroteIntroString = true;
        
        if (global.left_press) {
            if (sel[0] > 0)
                sel[0]--;
            else
                sel[0] = 3;
            
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.right_press) {
            if (sel[0] < 3)
                sel[0]++;
            else
                sel[0] = 0;
            
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.confirm) {
            if (sel[1] == 0)
                state = 1;
            if (sel[1] == 1)
                state = 2;
            if (sel[1] == 2)
                state = 3;
            if (sel[1] == 3)
                state = 4;
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
        }*/
        
        if (global.cancel) {
            state = 0;
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false)
        }
    }
}

#endregion

#region -- AT MERCY --

if (cooldown > 0)
    cooldown--;

if (instance_exists(global.monster)) {
    if (state == 4) {
        instance_destroy(obj_typer);
        if (!instance_exists(obj_typer)) {
            if (fleeable) {
                if (spareable == true)
                    create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "   \\Cy* Spare\\Cw#   * Flee");
                else
                    create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "   * Spare#   * Flee");
            }
            else {
                if (spareable == true)
                    create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_yellow, "   * Spare");
                else
                    create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "   * Spare");
            }
        }
        
        obj_battleheart.x = obj_uborder.x + 30;
        obj_battleheart.y = obj_uborder.y + 30 + (sel[4] * 35);
        
        if (global.up_press) {
            if (fleeable) {
                if (sel[4] > 0)
                    sel[4]--;
                else
                    sel[4] = 1;
            }
            audio_play_sound(snd_menuswitch, 10, false)
        }
        if (global.down_press) {
            if (fleeable) {
                if (sel[4] < 1)
                    sel[4]++;
                else
                    sel[4] = 0;
            }
            audio_play_sound(snd_menuswitch, 10, false)
        }
        
        if (global.confirm) && (cooldown == 0) {
            show_debug_message(string(state));
            if (sel[4] == 0) {
                if (spareable) {
                    if (state == 4)
                        instance_destroy(obj_typer);
                    
                    obj_battleheart.x = -9999;
                    obj_battleheart.y = -9999;
                    
                    state = 999;
                    sel[4] = 0;
                    sel[0] = -1;
                }
                else
                    state = -1;
            }
            if (sel[4] == 1) {
                randomize();
                chance = irandom(100);
                
                if (chance > 66) {
                    instance_create(obj_battleheart.x, obj_battleheart.y, obj_battleheart_gtfo);
                    
                    if (state == 4)
                        instance_destroy(obj_typer);
                    
                    obj_battleheart.x = -9999;
                    obj_battleheart.y = -9999;
                    
                    chance = -1;
                    state = 997;
                    sel[4] = 0;
                }
                else
                    state = -1;
            }
        }
        
        if (global.cancel) {
            state = 0;
            sel[4] = -1;
            
            obj_battleheart.x = -9999;
            obj_battleheart.y = -9999;
            
            audio_play_sound(snd_menuselect, 10, false);
            
            instance_destroy(obj_typer);
        }
    }

    if (state == 997) {
        audio_play_sound(snd_flee, 10, false);
        
        state = 998;
    }
    if (state == 998) {
        if (!instance_exists(obj_typer))
            create_text_instant(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, choose("* Don't slow me down.", "* I've got better to do."));
        
        if (alarm[0] < 0)
            alarm[0] = room_speed;
    }
    
    if (state == 999) {
        mus_stop(4);
        global.gold += goldReward;
        
        audio_play_sound(snd_dust, 10, false);
        
        if (global.monster.body[0] != -1)
            global.monster.body[0].spared = true;
        if (global.monster.body[1] != -1)
            global.monster.body[1].spared = true;
        if (global.monster.body[2] != -1)
            global.monster.body[2].spared = true;
        state = 1000;
    }
    if (state == 1000) {
        if (!instance_exists(obj_typer))
            create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "* YOU WON!^1#* You earned 0 XP and " + string(goldReward) + " gold.", false);
        
        if (obj_typer.writing == false) && (global.confirm) {
            if (alarm[0] < 0)
                alarm[0] = 1;
        }
    }
}

#endregion

#region -- BATTLE END (FIGHT) --

if (state == 10000) {
    if (instance_exists(obj_targetchoice))
        instance_destroy(obj_targetchoice);
    
    if (instance_exists(obj_target))
        obj_target.done = true;
    
	mus_stop(4);
	
    if (!instance_exists(obj_typer))
        create_text(obj_uborder.x, obj_uborder.y, "DEFAULT-BATTLE", c_white, "* YOU WON!^1#* You earned " + string(xpReward) + " XP and " + string(goldReward) + " gold.", false);
        
    if (obj_typer.writing == false) && (global.confirm) {
        if (alarm[0] < 0)
            alarm[0] = 1;
    }
}

#endregion

#region -- WHEN THE PLAYER DIES --

if (global.hp <= 0) {
	global.soulX = obj_battleheart.x;
	global.soulY = obj_battleheart.y;
	
	room_goto(room_gameover);
}

#endregion

#region -- BOX MOVEMENT --

if (obj_uborder.x == global.boardX1) &&
    (obj_uborder.y == global.boardY1) &&
    (obj_dborder.x == global.boardX2) &&
    (obj_dborder.y == global.boardY2) {
        
        box_id_prev = global.board;
		
		if (state == -1) {
            state = 0;
			ready = false;
		}
}
else {
    obj_battleheart.moveable = true;
    
    if (obj_uborder.y != global.boardY1) {
        with (obj_uborder)
            mp_linear_step(x, global.boardY1, 15, false);
    }
    if (obj_uborder.x != global.boardX1) {
        with (obj_uborder)
            mp_linear_step(global.boardX1, y, 15, false);
    }
    
    if (obj_dborder.y != global.boardY2) {
        with (obj_dborder)
            mp_linear_step(x, global.boardY2, 15, false);
    }
    if (obj_dborder.x != global.boardX2) {
        with (obj_dborder)
            mp_linear_step(global.boardX2, y, 15, false);
    }
}

#endregion

global.selectedMonster = global.monster.body[sel[1]];