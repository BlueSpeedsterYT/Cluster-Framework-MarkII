/// @description Alarm

if (has_dropped)
{
    if (life_alarm > 0)
	{
		--life_alarm;
		if (life_alarm <= 0)
		{
			instance_destroy();
		}
	}
}