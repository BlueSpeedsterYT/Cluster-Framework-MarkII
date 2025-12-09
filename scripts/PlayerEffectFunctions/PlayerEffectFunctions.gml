/// @function player_invin_spark_create()
function player_invin_spark_create()
{
	if (/* config_get("advance_flicker") and */ invincibility_time > 0)
	{
	    if (mod_time(invincibility_time, 2, 4) == 0) 
		{
			particle_create(x + random_range(-x_radius, x_radius), y + random_range(-y_radius, y_radius), global.ani_invin_spark_v0);
		}
	}
}

/// @function player_shield_create()
function player_shield_create()
{
	shield_effect = new player_effect();
	shield_reset = false;
	shield_hide = false;
	shield_advance = false;
}

/// @function player_shield_late_update()
function player_shield_late_update()
{
	with (shield_effect)
	{
		if (other.invincibility_time <= 0)
		{
			switch (other.shield_index)
			{
				case SHIELD_TYPE.MAGNETIC:
				{
					animation_set(global.ani_shield_magnetic);
					break;
				}
				default:
				{
					animation_set(global.ani_shield_basic);
					break;
				}
			}
		}
		else
		{
			animation_set(global.ani_invin_effect);
		}
		
		x = (other.x div 1);
        y = (other.y div 1);
	}
	
	if (shield_reset != false) shield_reset = false;
	
	if (shield_index == SHIELD_TYPE.NONE and invincibility_time <= 0)
	{
		with (shield_effect)
		{
			if (not is_undefined(animation_data.ani))
		    {
		        animation_set(undefined);
		    }
		}
	}
	
	shield_advance = (shield_index == SHIELD_TYPE.BASIC or shield_index == SHIELD_TYPE.MAGNETIC or invincibility_time > 0);
	
	if (/* config_get("advance_flicker") and */ shield_advance)
	{
		shield_hide = mod_time(ctrlWindow.image_index, 2, 2);
	}
	else
	{
		shield_hide = false;
	}
}

/// @function player_shield_draw()
function player_shield_draw()
{
	with (shield_effect)
	{
        image_angle = other.gravity_direction;
		image_xscale = 1;
		image_alpha = ((/* config_get("advance_flicker") and */ other.shield_advance) or not other.shield_advance) ? 1 : 0.6;
		if (not other.shield_hide)
		{
			draw();
		}
	}
}