/// @description Instantiate border solids

topSolidInst = instance_create_depth(left, top, 0, obj_solid);
bottomSolidInst = instance_create_depth(left, bottom, 0, obj_solid);
leftSolidInst = instance_create_depth(left, top, 0, obj_solid);
rightSolidInst = instance_create_depth(right, top, 0, obj_solid);