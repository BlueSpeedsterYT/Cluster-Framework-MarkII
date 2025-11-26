/// @description Setup
// Inherit the parent event
event_inherited();

magnetized = false;
life_alarm = 0;
x_speed = 0;
y_speed = 0;
gravity_force = 0.09375;

// Collision
tilemaps = [layer_tilemap_get_id("TilesMain")];
semisolid_tilemap = layer_tilemap_get_id("TilesSemisolid");
if (layer_exists("TilesLayer0"))
{
	array_push(tilemaps, layer_tilemap_get_id("TilesLayer0"));
	collision_layer = 0;
}