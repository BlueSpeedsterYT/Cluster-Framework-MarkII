/// @description Animate
image_index = mod_time(ctrlWindow.image_index, ring_frame_rate div pick(has_dropped, 1, 2), sprite_get_number(sprite_index));