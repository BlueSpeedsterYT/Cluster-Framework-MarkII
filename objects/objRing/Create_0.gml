/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-8, -8, 8, 8);
ring_frame_rate = 8;
has_dropped = false;
reaction = function(pla)
{
	if (collision_player(0, pla))
    {
        if (pla.state != player_is_hurt or (pla.invulnerability_time > 0 and pla.invulnerability_time < 90))
		{
			pla.player_gain_rings(is_super_ring ? 10 : 1, is_super_ring);
	        particle_create(x, y, global.ani_ring_sparkle_v0);
			instance_destroy();
		}
    }
};