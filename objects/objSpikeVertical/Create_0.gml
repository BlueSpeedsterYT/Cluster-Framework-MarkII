/// @description Initialize
event_inherited();
image_speed = 0;
hitboxes[0] = new hitbox(c_maroon, -16, -8, 15, 15);
reaction = function(pla)
{
	if (collision_player(0, pla) != 0)
    {
        // pla.player_damage(id);
    }
};