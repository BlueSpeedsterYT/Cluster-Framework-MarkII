/// @function rect([left], [top], [right], [bottom])
/// @description Creates a rectangle with arguments assuming (0, 0) origin.
/// @param {Real} left Left radius of the rectangle.
/// @param {Real} top Top radius of the rectangle.
/// @param {Real} right Right radius of the rectangle.
/// @param {Real} bottom Bottom radius of the rectangle.
function rect(_left = 0, _top = 0, _right = 0, _bottom = 0) constructor
{
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
    static set_size = function(_left = 0, _top = 0, _right = 0, _bottom = 0)
    {
        left = _left;
        top = _top;
        right = _right;
        bottom = _bottom;
    }
}

/// @function convert_hex(val)
/// @description Converts an 8-bit signed hex value into a decimal number.
/// @param {Real} val Value to convert.
/// @returns {Real}
function convert_hex(val)
{
    if (val >= 128) val -= 256;
    return val;
}

/// @function string_pad(number, digits)
/// @description Returns a number string with padded zeros from the amount provided. Ported from GM8.2.
/// @param {String} number String
/// @param {Integer} digits Amount of digits to pad out the zeros.
/// @returns {String}
function string_pad(number, digits)
{
	return string_repeat("-", number < 0) + string_replace_all(string_format(abs(number), digits, 0), " ", "0");
}

/// @function pick(which, opt1, opt2, ...)
/// @description Returns one of the arguments depending on the first argument. Ported from GM8.2.
/// @param {Real} which Which option to return
/// @param {Real} opt1 First option picked.
/// @param {Real} opt2 Second option picked.
/// @returns {Real}
function pick()
{
	return argument[(max(0, argument[0]) mod (argument_count - 1)) + 1];
}

/// @function esign(val, def)
/// @description Returns the sign of the value, or the default if the value is 0. Ported from GM8.2.
/// @param {Real} val Value to get the sign of.
/// @param {Real} def Default value to give if the value is 0.
/// @returns {Real}
function esign(val, def)
{
	if (val == 0) return def;
	else return sign(val);
}

/// @function direction_to_object(obj)
/// @description Returns the targeted object's distance in degrees. Ported from GM8.2.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Real}
function direction_to_object(obj)
{
	var n = (obj >= 100000) ? obj : instance_nearest(x, y, obj);
	if(n == noone) return -1;
	return (point_direction(x, y, n.x, n.y));
}

/// @function choose_weighted(val1, weight1, val2, weight2, ...)
/// @description Returns one of the values while minding their "weights" - in other words, a "biased" version of choose.
/// @param {Real} val1 First value to get the weight of.
/// @param {Real} weight1 The weight to get from the first value.
/// @param {Real} val2 Second value to get the weight of.
/// @param {Real} weight2 The weight to get from the second value.
/// @returns {Real}
function choose_weighted()
{
    var n = 0;
    for (var i = 1; i < argument_count; i += 2) {
        if (argument[i] <= 0) continue;
        n += argument[i];
    }
    
    n = random(n);
    for (var i = 1; i < argument_count; i += 2) {
        if (argument[i] <= 0) continue;
        n -= argument[i];
        if (n < 0) return argument[i - 1];
    }
    
    return argument[0];
}

/// @function mod_time(time, frequency, maximum)
/// @description Returns the time divided by the frequency, kept between 0 and the max - max exclusive.
/// @param {Real} time
/// @param {Integer} frequency
/// @param {Integer} maximum Maximum value.
/// @returns {Integer}
function mod_time(time, frequency, maximum)
{
	return (time div frequency) mod maximum;
}

/// @function wrap(val, minimum, maximum)
/// @description Wraps the given value between the minimum and maximum inclusively.
/// @param {Real} val Value to wrap.
/// @param {Real} minimum Minimum value.
/// @param {Real} maximum Maximum value.
/// @returns {Real}
function wrap(val, minimum, maximum)
{
    if (val < minimum) return maximum;
    else if (val > maximum) return minimum;
    else return val;
}

/// @function draw_self_floored()
/// @description A floored version of the existing draw_self() function.
function draw_self_floored()
{
	if (sprite_index != -1) draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

/// @function angle_wrap(ang)
/// @description Wraps the given angle between 0 and 359 degrees inclusively.
/// @param {Real} ang Angle to wrap.
/// @returns {Real}
function angle_wrap(ang)
{
	return (ang mod 360 + 360) mod 360;
}

/// @function rotate_towards(dest, src, [amt])
/// @description Rotates the source angle to the destination angle.
/// @param {Real} dest Destination angle.
/// @param {Real} src Source angle.
/// @param {Real} amt The maximum amount to straighten by.
/// @returns {Real}
function rotate_towards(dest, src, amt = 2.8125)
{
	if (src != dest)
	{
		var diff = angle_difference(dest, src);
		return src + min(amt, abs(diff)) * sign(diff);
	}
    return src;
}

/// @function instance_in_view([obj], [view_padding])
/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [obj] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [view_padding] Distance in pixels to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(obj = id, view_padding = CAMERA_PADDING)
{
	var left = global.main_camera.get_x();
	var top = global.main_camera.get_y();
	var right = left + CAMERA_WIDTH;
	var bottom = top + CAMERA_HEIGHT;
	
	with (obj)
	{
		return point_in_rectangle(x, y, left - view_padding, top - view_padding, right + view_padding, bottom + view_padding);
	}
}

/// @function particle_create(x, y, ani, [xspd], [yspd], [xaccel], [yaccel])
/// @description Creates a particle with the given animation.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Struct.animation} ani animation of the particle.
/// @param {Real} [xspd] x-speed of the particle.
/// @param {Real} [yspd] y-speed of the particle.
/// @param {Real} [xaccel] x-acceleration of the particle.
/// @param {Real} [yaccel] y-acceleration of the particle.
/// @returns {Id.Instance}
function particle_create(ox, oy, ani, xspd = 0, yspd = 0, xaccel = 0, yaccel = 0)
{
    var particle = instance_create_depth(ox, oy, layer_get_depth("Interactables") - DEPTH_OFFSET_PARTICLE, objParticle);
    with (particle)
    {
        animation_set(ani);
        x_speed = xspd;
        y_speed = yspd;
        x_acceleration = xaccel;
        y_acceleration = yaccel;
    }
    return particle;
}

/// @function particle_create_ext(x, y, ani, [xscale], [yscale], [angle], [alpha], [xspd], [yspd], [xaccel], [yaccel])
/// @description Creates a particle with the given animation.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Struct.animation} ani animation of the particle.
/// @param {Real} [xscale] horizontal scale of the particle.
/// @param {Real} [yscale] vertical scale of the particle.
/// @param {Real} [angle] angle of the particle.
/// @param {Real} [alpha] alpha level of the particle.
/// @param {Real} [xspd] x-speed of the particle.
/// @param {Real} [yspd] y-speed of the particle.
/// @param {Real} [xaccel] x-acceleration of the particle.
/// @param {Real} [yaccel] y-acceleration of the particle.
/// @returns {Id.Instance}
function particle_create_ext(ox, oy, ani, xscale = 1, yscale = 1, angle = 0, alpha = 1, xspd = 0, yspd = 0, xaccel = 0, yaccel = 0)
{
    var particle = instance_create_depth(ox, oy, layer_get_depth("Interactables") - DEPTH_OFFSET_PARTICLE, objParticle);
    with (particle)
    {
        animation_set(ani);
        image_xscale = xscale;
        image_yscale = yscale;
        image_angle = angle;
        image_alpha = alpha;
        x_speed = xspd;
        y_speed = yspd;
        x_acceleration = xaccel;
        y_acceleration = yaccel;
    }
    return particle;
}

/// @function draw_reset()
/// @description Resets draw color, alpha, and text alignment. Ported from GM8.2.
function draw_reset()
{
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}