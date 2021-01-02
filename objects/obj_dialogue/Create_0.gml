drawOnTop = obj_player.y > __view_get( e__VW.HView, view_current ) / 2;
viewX = __view_get( e__VW.XView, view_current );
viewY = __view_get( e__VW.YView, view_current );

if (drawOnTop) {
    instance_create(viewX + 30, viewY + 15, obj_typer);
}
else {
    instance_create(viewX + 30, viewY + 170, obj_typer);
}

if (instance_exists(obj_cmenu)) {
    instance_destroy(obj_cmenu);
}

global.cutscene = true;

