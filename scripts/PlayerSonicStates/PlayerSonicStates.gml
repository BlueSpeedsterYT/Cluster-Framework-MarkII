/// @function sonic_is_drop_dashing(phase)
function sonic_is_drop_dashing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set Timer
			drop_dash_timer = 20;
			break;
		}
		case PHASE.STEP:
		{
			// Accelerate
			if (input_axis_x != 0)
			{
				image_xscale = input_axis_x;
				if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
				{
					x_speed += air_acceleration * input_axis_x;
					if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
					{
						x_speed = speed_cap * input_axis_x;
					}
				}
			}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Release the Drop Dash
			if (on_ground)
			{
				if (drop_dash_timer == 0)
				{
					var drop_dash_max_speed = 12;
					var drop_dash_speed = 8;

					// Set facing direction
					if (input_axis_x != 0 and sign(image_xscale) != input_axis_x) image_xscale = input_axis_x;

					// Calculate the Drop Dash speed
					if (x_speed == 0 || sign(x_speed) == input_axis_x) drop_dash_speed = min(drop_dash_speed + abs(x_speed / 4), drop_dash_max_speed);
					else if (local_direction != 0) drop_dash_speed = min(drop_dash_speed + abs(x_speed / 2), drop_dash_max_speed);

					// Set the Drop Dash speed
					x_speed = drop_dash_speed * image_xscale;
					
					// Lag the camera
					with (camera) lag_x = (24 - abs(other.x_speed)) div 1;
					
					// Play Sound
					audio_stop_sound(sfxDropDash);
					audio_play_single(sfxSpinDash);
					
					// Create drop dash dust
					var ox = x + dsin(gravity_direction) * y_radius;
					var oy = y + dcos(gravity_direction) * y_radius;
					particle_create_ext(ox, oy, global.ani_drop_dash_v0, image_xscale);
					
					// Roll Away!
					return player_perform(player_is_rolling);
				}
				else if (player_try_landing()) return true;
			}
			
			// Perform Drop Dash
			if (input_button.jump.check)
			{
				if (drop_dash_timer > 0)
				{
					--drop_dash_timer;
					
					// Activate Drop Dash
					if (drop_dash_timer <= 0)
					{
						animation_init(PLAYER_ANIMATION.ROLL);
						audio_play_single(sfxDropDash);
					}
				}
			}
			// Reset to Jump
			else if (drop_dash_timer < 20)
			{
				drop_dash_timer = 20;
				animation_init(PLAYER_ANIMATION.JUMP, 1);
				return player_perform(player_is_jumping, false);
			}
			// Reset to previous state
			else return player_perform(state_previous, false);
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > air_drag_threshold)
			{
				x_speed *= air_drag;
			}
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + gravity_force, gravity_cap);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}