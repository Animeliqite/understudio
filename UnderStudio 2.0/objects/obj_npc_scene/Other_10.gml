/// @description Run scene

if (global.dxInterpreter.state != DiannexInterpreterState.Inactive) exit;
event_inherited();
global.dxInterpreter.runScene(scene);