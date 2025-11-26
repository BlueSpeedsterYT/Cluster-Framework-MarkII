/// @description Create Dropped Ring

if (has_dropped)
{
    with (instance_create_depth(x, y, depth, objWorldRing))
    {
        is_super_ring = other.is_super_ring;
		has_dropped = true;
		life_alarm = 256;
        x_speed = clamp(other.hspeed, -4, 4);
        y_speed = clamp(other.vspeed, -4, 4);
    }
}