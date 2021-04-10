if (textAlpha > 0) {
     textAlpha -= 0.05;
     outlineAlpha -= 0.05;
    
     alarm[1] = 1;
}
else {
     textAlpha = 1;
     outlineAlpha = 0;
     if (textNo >= array_length(text) - 1) {
         global.textNo = 0;
         instance_destroy();
     }
     else {
         global.textNo++;
         textNo++;
         i = 1;
         charNo = 1;
         
         alarm[0] = textSpeed;
     }
}

