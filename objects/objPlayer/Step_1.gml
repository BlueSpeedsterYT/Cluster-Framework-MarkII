/// @description Count
if (control_lock_time > 0 and on_ground)
{
	--control_lock_time;
}

if (invulnerability_time > 0)
{
	--invulnerability_time;
}

if (superspeed_time > 0)
{
    --superspeed_time;
    if (superspeed_time <= 0)
	{
        player_refresh_physics();
    }
}

if (invincibility_time > 0)
{
    --invincibility_time;
}

if (remaining_air_time > 0)
{
    --remaining_air_time;
	// TODO: Set up Drowning (See how SonicForGMS handles it)
}

animation_update();
with (spin_dash_effect) animation_update();
with (shield_effect) animation_update();

// Record
if (player_index == 0)
{
	player_record_cpu_input(CPU_INPUT.X);
	player_record_cpu_input(CPU_INPUT.Y);
	player_record_cpu_input(CPU_INPUT.JUMP);
	player_record_cpu_input(CPU_INPUT.JUMP_PRESSED);
}