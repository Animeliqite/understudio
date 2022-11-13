/// @description Initialize

state = -1;
stateExecutedOnce = false;
prevState = state;
subState = 0;

dialogueText = "";
dialogueFace = undefined;
dialogueFaceIndex = 0;
dialogueVoice = snd_defaultvoice;
dialogueCompleted = false;
dialogueFont = fnt_main;
dialogueWriter = noone;
dialogueIsOnTop = undefined;
dialogueAlignY = 0;