/// @function sonic_is_homing(phase)
function sonic_is_homing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Reset Speed
			y_speed = 0;
			x_speed = 0;
			
			// Reset Air
			player_ground(undefined);
            
            // Animate
			animation_init(PLAYER_ANIMATION.ROLL);
			break;
		}
		case PHASE.STEP:
		{
			// Reset Homing Attack
			if (homing_time == 0 || !instance_exists(homing_inst))
	        {
	            x_speed = 0;
	            y_speed = 0;
	            return player_perform(player_is_jumping, false);
	        }
	        else // Go to the targeted object.
	        {
	            var homing_angle = angle_wrap(direction_to_object(homing_inst) - gravity_direction);

	            x_speed = lengthdir_x(homing_speed, homing_angle);
	            y_speed = lengthdir_y(homing_speed, homing_angle);
	            --homing_time;
	        }
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}