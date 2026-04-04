// Update variables
top = _y - height;
bottom = _y + height;
left = _x - width;
right = _x + width;

// Top border
topSolidInst.image_xscale = (right - left) / 20;
topSolidInst.image_yscale = borderWidth / 20;
topSolidInst.x = left;
topSolidInst.y = top;

// Bottom border
bottomSolidInst.image_xscale = (right - left) / 20;
bottomSolidInst.image_yscale = borderWidth / 20;
bottomSolidInst.x = left;
bottomSolidInst.y = bottom - borderWidth;

// Left border
leftSolidInst.image_xscale = borderWidth / 20;
leftSolidInst.image_yscale = (bottom - top) / 20;
leftSolidInst.x = left;
leftSolidInst.y = top;

// Right border
rightSolidInst.image_xscale = borderWidth / 20;
rightSolidInst.image_yscale = (bottom - top) / 20;
rightSolidInst.x = right - borderWidth;
rightSolidInst.y = top;