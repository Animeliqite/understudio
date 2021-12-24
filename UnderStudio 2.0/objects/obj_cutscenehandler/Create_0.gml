/// @description Initialize

gotOnce = false; // A fixer variable for executing things once in a cutscene script
sleepTimer = 0; // Current amount of how much the cutscene order has waited
currentOrder = 0; // The current order

curveTimer = []; // Current amount of how much the animation curve has progressed
playAnimation = false; // Will we play an animation?
animationOrder = 0; // The current animation order
animationData = -1;