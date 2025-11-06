/// @description Destroy off-screen (otherwise, animate)
if (not instance_in_view(id, max(sprite_width, sprite_height))) 
{
	instance_destroy();
}

image_index += anim_speed;
if (anim_speed > 0) {
	anim_speed -= spin_friction;
}
if (life < 64) {
	visible = !visible;
}