/// @description bt_spawn_dust(x, y, filename)
/// @param x
/// @param y
/// @param filename
// Creates dust effect at a given coordinate, using the file as data.

function bt_spawn_dust(targX, targY, fname, freeze)
{
	if (freeze == undefined)
		freeze = 1;
	
	fname = "data/mp/" + fname + ".tsmp";
	if (!file_exists(fname))
	{
	    show_error("Missing monster particle file with name " + fname, false);
	    exit;
	}
	var buff = buffer_load(fname);

	if (buffer_read(buff, buffer_u8) != $54 ||
	    buffer_read(buff, buffer_u8) != $53 ||
	    buffer_read(buff, buffer_u8) != $4D ||
	    buffer_read(buff, buffer_u8) != $50 ||
	    buffer_read(buff, buffer_u8) != 0) // version
	{
	    show_error("Invalid monster particle file", false);
	    buffer_delete(buff);
	    exit;
	}
	
	var blend = (global.flavor_sprites) ? self.flavorColor : c_white;

	var height = targY + (buffer_read(buff, buffer_u16)*2);
	var _x = targX;
	var life = 15;
	for (var _y = targY; _y < height; {_y += 2; life += 0.5;})
	{   
	    var next = false;
	    while (!next)
	    {
	        switch (buffer_read(buff, buffer_u8))
	        {
	            case 0: // White line
					var w = buffer_read(buff, buffer_u16);
	                with (instance_create(_x, _y, obj_dustpix))
					{
						image_blend = blend;
						image_xscale = w;
						alarm[0] = floor(life) * freeze;
						self.freeze = freeze;
					}
	                _x += w * 2;
	                break;
	            case 1: // Black line
					var w = buffer_read(buff, buffer_u16);
	                with (instance_create(_x, _y, obj_dustpix))
					{
						image_blend = c_black;
						image_xscale = w;
						alarm[0] = floor(life) * freeze;
						self.freeze = freeze;
						type = 1;
					}
	                _x += w * 2;
	                break;
	            case 2: // Ignore
	                _x += buffer_read(buff, buffer_u16) * 2;
	                break;
	            case 255: // Next line
	                next = true;
	                _x = targX;
	                break;
	        }
	    }
	}

	buffer_delete(buff);
}
