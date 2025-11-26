/// @description Move and Magnetize
// Inherit the parent event
event_inherited();

#region Movement

if (has_dropped)
{
	var sine = dsin(gravity_direction);
	var cosine = dcos(gravity_direction);
	var ox = cosine * x_speed;
	var oy = sine * x_speed;

	x += ox;
	y -= oy;

	for (var n = array_length(tilemaps) - 1; n > -1; --n)
	{
		var inst = tilemaps[n];
		if (place_meeting(x + ox, y - oy, inst) and not place_meeting(xprevious, yprevious, inst))
		{
		    while (place_meeting(x, y, inst))
		    {
		        x -= sign(ox);
		        y += sign(oy);
		    }

		    x_speed *= -1;
		}
	}

	ox = sine * y_speed;
	oy = cosine * y_speed;
	x += ox;
	y += oy;
	y_speed += gravity_force;

	// Evaluate semisolid tilemap collision
    if (semisolid_tilemap != -1)
    {
   	    var valid = array_contains(tilemaps, semisolid_tilemap);
   	    if (y_speed > 0)
   	    { 
            if (not valid) array_push(tilemaps, semisolid_tilemap);
   	    }
   	    else if (valid) array_pop(tilemaps);
    }
	
	for (var n = array_length(tilemaps) - 1; n > -1; --n)
	{
		var inst = tilemaps[n];
		if (place_meeting(x + ox, y + oy, inst) and not place_meeting(xprevious, yprevious, inst))
		{
		    while (place_meeting(x, y, inst))
		    {
		        x -= sign(ox);
		        y -= sign(oy);
		    }

		    y_speed *= -1;
		}
	}
	
	// Kill the Ring Object if not in view:
	if (not instance_in_view()) instance_destroy();
}

#endregion

#region Magnetize

if (instance_exists(global.players[0]))
{
    var player_inst = global.players[0];

    // TODO: Re-add the call for the Electric Shield when that's added.
	if (player_inst.shield_index == SHIELD_TYPE.MAGNETIC)
    {
        if (distance_to_object(player_inst) < 64)
        {
            magnetized = true;
            instance_destroy();
        }
    }
}

#endregion