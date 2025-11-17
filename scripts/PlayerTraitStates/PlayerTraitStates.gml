/// @function player_trait_boost([tag])
/// @description Dynamite Boost Time!
/// @params {Bool} [tag] Used for the "Sonic Accelerator" tag move, enables tag only functions
function player_trait_boost(tag = false)
{
	var boost_index = (global.rings > 10 ? 1 : 0) + min(global.rings div 50, 3);
	var boost_threshold = [8, 7.96875, 6.5625, 5.625, 4.21875];
	var boost_physics = [[0.03125, 0.25], [0.046875, 0.25], [0.0546875, 0.25], [0.0625, 0.25], [0.0703125, 0.25]];
	
	// Have to start at the base values and redo their math:
	player_refresh_physics();
	
	// Increase acceleration:
	if (boost_mode)
	{
	    acceleration += (2 div 256) * min(global.rings div 50, 3);
	    if (global.rings > 10) acceleration += (4 div 256);
	}

	// Boost mode:
	if (boost_mode)
	{
	    if (on_ground and abs(x_speed) < 4.5 and (not tag))
	    {
	        boost_mode = false;
	        boost_speed = 0;
	    }
	    else if (on_ground) boost_speed = boost_threshold[boost_index];
	}
	else if (save_get("boost", true) == true 
	and on_ground and abs(x_speed) >= speed_cap and ((not underwater) or tag))
	{
	    if (input_axis_x != 0 && input_allow) boost_speed += acceleration;

	    if (boost_speed >= boost_threshold[boost_index])
	    {
	        boost_mode = true;
	        //audio_play_sfx("snd_boost_mode", true);
	        if (player_index == 0) 
			{
				with (camera) lag_x = 16;
			}
	    }
	}
	else boost_speed = 0;

	// Change the physics upon boosting:
	if (boost_mode && superspeed_time <= 0) 
	{
		speed_cap *= 2;
		acceleration = boost_physics[boost_index][0];
		deceleration = boost_physics[boost_index][1];
	}
}