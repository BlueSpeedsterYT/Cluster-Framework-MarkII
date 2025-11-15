/// @description Initialize
image_speed = 0;

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

// Timing
stage_time = 0;
time_limit = 36000;
time_over = false;
time_enabled = false;

// alarm[0] = 5;

// Identify stage
switch (room)
{
	case rmTest:
	{
		name = "DEMONSTRATION";
		act = 1;
		is_hub = false;
		audio_swap_music(bgmMadGear);
		break;
	}
	case rmTestNew:
	{
		name = "DEMONSTRATION";
		act = 1;
		is_hub = false;
		audio_swap_music(bgmExtraBattle1);
		break;
	}
	case rmR99Map:
	{
		name = "ROUTE 99";
		act = 0;
		is_hub = true;
		audio_swap_music(bgmR99Map);
		break;
	}
}

// Create UI elements
instance_create_layer(0, 0, "Display", objHUD);

// Set collision masks
switch (room)
{
    case rmTestNew:
    {
        layer_tilemap_set_colmask(layer_tilemap_get_id("TilesMain"), sprSunsetHillCollision);
        layer_tilemap_set_colmask(layer_tilemap_get_id("TilesSemisolid"), sprSunsetHillCollision);
        layer_tilemap_set_colmask(layer_tilemap_get_id("TilesLayer0"), sprSunsetHillCollision);
        layer_tilemap_set_colmask(layer_tilemap_get_id("TilesLayer1"), sprSunsetHillCollision);
        break;
    }
}