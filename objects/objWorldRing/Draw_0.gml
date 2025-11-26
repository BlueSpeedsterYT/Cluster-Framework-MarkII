/// @description Draw

image_alpha = pick((has_dropped && life_alarm < 30), 1, mod_time(life_alarm, 2, 2));
draw_self_floored();