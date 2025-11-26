/// @description Move
// Inherit the parent event
event_inherited();

#region Movement

if (instance_exists(global.players[0]))
{
	var player_inst = global.players[0];
	
	var xx = sign(player_inst.x - x);
    var yy = sign(player_inst.y - y);

    hspeed += xx * (0.1875 + (0.75 * (sign(hspeed) != xx)));
    vspeed += yy * (0.1875 + (0.75 * (sign(vspeed) != yy)));
    speed = min(abs(speed), 64) * sign(speed);

    // Drop a normal ring when no longer magnetized:
    if (player_inst.shield_index != SHIELD_TYPE.MAGNETIC)
    {
        has_dropped = true;
        instance_destroy();
    }
}

#endregion