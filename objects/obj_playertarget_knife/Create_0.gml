chances = 0;

aimY = y;
aimX = (chances == 0 ? global.boardX1 : global.boardX2);
aimImageIndex = 0;
damageCalculation = 0;
aimTween = TweenFire(self, EaseLinear, TWEEN_MODE_ONCE, false, 0, 45, "aimX", aimX, (chances == 0 ? global.boardX2 : global.boardX1));

obj_battlemanager.stateSelection = 1;
done = false;
alarm[0] = 2;