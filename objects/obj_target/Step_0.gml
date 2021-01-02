if (done == true) {
    if (image_alpha > 0) {
        image_alpha -= 0.066;
        image_xscale -= 0.066;
    }
    else
        instance_destroy();
}

