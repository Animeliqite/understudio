if (textAlpha > 0) {
   textAlpha -= 0.05;
   outlineAlpha -= 0.05;
   
   alarm[2] = 1;
}
else {
     instance_destroy();
}

