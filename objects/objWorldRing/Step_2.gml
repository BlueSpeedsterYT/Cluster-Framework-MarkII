/// @description Move and Magnetize
// Inherit the parent event
event_inherited();

#region Movement

if (has_dropped)
{
	// TODO: Implement movement and proper collision for this.
	// Especially Collision as it expects object collision *ONLY*
	
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