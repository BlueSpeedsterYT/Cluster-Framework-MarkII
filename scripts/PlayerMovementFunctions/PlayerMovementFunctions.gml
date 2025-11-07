/// @function player_move_on_ground()
/// @description Updates the player's position on the ground and checks for collisions.
function player_move_on_ground()
{
	// Ride moving platforms
	with (instance_place(x div 1 + dsin(mask_direction), y div 1 + dcos(mask_direction), objSolid))
	{
		var dx = x - xprevious;
		var dy = y - yprevious;
		if (dx != 0) other.x += dx;
		if (dy != 0) other.y += dy;
	}
	
	/* AUTHOR NOTE: using `instance_place` here is cheeky as the player's sprite mask is used
	to check for collision instead of their virtual mask.
	However, unless the player's virtual mask is wider than their sprite's, this is not an issue. */
	
	// Calculate the number of steps for collision checking
	var total_steps = 1 + (abs(x_speed) div x_radius);
	var step = x_speed / total_steps;
	var sine = dsin(direction);
	var cosine = dcos(direction);
	
	// Loop over the number of steps
	repeat (total_steps)
	{
		// Move by a single step
		player_new_position(x + (cosine * step), y - (sine * step));
		if (player_in_bounds() == false)
		{
			player_damage(self);
		}
		
		// Register nearby instances
		player_detect_entities();
		
		// Handle wall collision
		var tile_data = player_find_wall();
		if (tile_data != noone)
		{
			var wall_sign = player_eject_wall(tile_data);
			
			// Stop moving and push
			if (sign(x_speed) == wall_sign)
			{
				x_speed = 0;
				if (sign(image_xscale) == wall_sign && input_axis_x == wall_sign) 
				{
					player_push_wall(tile_data, wall_sign);
				}
			}
		}
		
		// Handle floor collision
		if (on_ground)
		{
			tile_data = player_find_floor(ground_snap ? y_radius + y_tile_reach : y_radius + 1);
			if (tile_data != undefined)
			{
				player_ground(tile_data);
				player_rotate_mask();
			}
			else
			{
				on_ground = false;
			}
		}
	}
}

/// @function player_move_in_air()
/// @description Updates the player's position in the air and checks for collisions.
function player_move_in_air()
{
	// Calculate the number of steps for collision checking
	var total_x_steps = 1 + (abs(x_speed) div x_radius);
	var total_y_steps = 1 + (abs(y_speed) div y_radius);
	var x_step = x_speed / total_x_steps;
	var y_step = y_speed / total_y_steps;
	var sine = dsin(direction);
	var cosine = dcos(direction);
	
	// Loop over the number of steps
	repeat (total_x_steps)
	{
		// Move by a single step
		player_new_position(x + (cosine * x_step), y - (sine * x_step));
		if (player_in_bounds() == false)
		{
			player_damage(self);
		}
		
		// Register nearby instances
		player_detect_entities();
		
		// Handle wall collision
		var tile_data = player_find_wall();
		if (tile_data != noone)
		{
			var wall_sign = player_eject_wall(tile_data);
			
			// Stop moving
			if (sign(x_speed) == wall_sign)
			{
				x_speed = 0;
			}
		}
	}
	
	repeat (total_y_steps)
	{
		// Move by a single step
		player_new_position(x + (sine * y_step), y + (cosine * y_step));
		if (player_in_bounds() == false)
		{
			player_damage(self);
		}
		
		// Register nearby instances
		player_detect_entities();
		
		// Handle floor collision
		if (y_speed >= 0)
		{
			tile_data = player_find_floor(y_radius);
			if (tile_data != undefined)
			{
				landed = true;
				player_ground(tile_data);
				player_rotate_mask();
			}
		}
		else
		{
			// Handle ceiling collision
			tile_data = player_find_ceiling(y_radius);
			if (tile_data != undefined)
			{
				// Flip mask and land on the ceiling
				mask_direction = (mask_direction + 180) mod 360;
				landed = true;
				player_ground(tile_data);
				
				// Abort if rising slowly or the ceiling is too shallow
				if (y_speed > -4 or (local_direction >= 135 and local_direction <= 225))
				{
					// Slide against it
					sine = dsin(local_direction);
					cosine = dcos(local_direction);
					var g_speed = (cosine * x_speed) - (sine * y_speed);
					x_speed = cosine * g_speed;
					y_speed = -sine * g_speed;
					
					// Detach and exit loop
					landed = false;
					player_ground(undefined);
					break;
				}
			}
		}
		
		// Land
		if (landed)
		{
			// Calculate landing speed
			if (abs(x_speed) <= abs(y_speed) and local_direction >= 22.5 and local_direction <= 337.5)
			{
				x_speed = -y_speed * sign(dsin(local_direction));
				if (local_direction < 45 or local_direction > 315) x_speed *= 0.5;
			}
			
			// Stop falling and exit loop
			y_speed = 0;
			landed = false;
			break;
		}
		
		// Handle wall collision (again)
		tile_data = player_find_wall();
		if (tile_data != noone) player_eject_wall(tile_data);
	}
}