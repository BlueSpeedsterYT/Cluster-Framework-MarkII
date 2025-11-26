/// @description player_invin_spark_create()
function player_invin_spark_create()
{
	if (config_get("advance_flicker", false) and invincibility_time > 0)
	{
	    if (mod_time(invincibility_time, 2, 4) == 0) 
		{
			particle_create(x + random_range(-x_radius, x_radius), y + random_range(-y_radius, y_radius), global.ani_invin_spark_v0);
		}
	}
}