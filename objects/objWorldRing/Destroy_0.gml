/// @description Create Magnetized Ring

if (magnetized)
{
    with (instance_create_depth(x, y, depth, objMagnetizedRing))
    {
        sprite_index = other.sprite_index;
        is_super_ring = other.is_super_ring;
    }
}