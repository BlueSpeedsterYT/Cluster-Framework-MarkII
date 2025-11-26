/// @function box_collision(obj, xrad, yrad, invert_collision)
/// @description Checks if the given entity's mask intersects the object's mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} xrad Distance in pixels to extend the object's mask horizontally.
/// @param {Real} yrad Distance in pixels to extend the object's mask vertically.
/// @param {Bool} invert_collision Inverts the calculated collision
/// @returns {Bool}
function box_collision(obj, xrad, yrad, invert_collision)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	return (invert_collision ?
		collision_rectangle(x_int - yrad, y_int - xrad, x_int + yrad, y_int + xrad, obj, true, false) != noone :
		collision_rectangle(x_int - xrad, y_int - yrad, x_int + xrad, y_int + yrad, obj, true, false) != noone);
}

/// @function part_collision(obj, rotation, xrad, ylen)
/// @description Checks if the given entity's mask intersects a vertical portion of the object's mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} rotation Value for an angle.
/// @param {Real} xrad Distance in pixels to extend the object's mask horizontally.
/// @param {Real} ylen Distance in pixels to extend the line downward.
/// @returns {Bool}
function part_collision(obj, rotation, xrad, ylen)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(rotation);
	var cosine = dcos(rotation);
	
	var x1 = x_int - (cosine * xrad);
	var y1 = y_int + (sine * xrad);
	var x2 = x_int + (cosine * xrad) + (sine * ylen);
	var y2 = y_int - (sine * xrad) + (cosine * ylen);
	
	return collision_rectangle(x1, y1, x2, y2, obj, true, false) != noone;
}

/// @function beam_collision(obj, rotation, xdia, yoff)
/// @description Checks if the given entity's mask intersects a line from the object's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} rotation Value for an angle.
/// @param {Real} xdia Distance in pixels to extend the line horizontally on both ends.
/// @param {Real} yoff Distance in pixels to offset the line vertically.
/// @returns {Bool}
function beam_collision(obj, rotation, xdia, yoff)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(rotation);
	var cosine = dcos(rotation);
	
	var x1 = x_int - cosine * xdia + sine * yoff;
	var y1 = y_int + sine * xdia + cosine * yoff;
	var x2 = x_int + cosine * xdia + sine * yoff;
	var y2 = y_int - sine * xdia + cosine * yoff;
	
	return collision_line(x1, y1, x2, y2, obj, true, false) != noone;
}

/// @function ray_collision(obj, rotation, xoff, yrad)
/// @description Checks if the given entity's mask intersects a line from the object's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} rotation Value for an angle.
/// @param {Real} xoff Distance in pixels to offset the line horizontally.
/// @param {Real} yrad Distance in pixels to extend the line downward.
/// @returns {Bool}
function ray_collision(obj, rotation, xoff, yrad)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(rotation);
	var cosine = dcos(rotation);
	
	var x1 = x_int + cosine * xoff;
	var y1 = y_int - sine * xoff;
	var x2 = x_int + cosine * xoff + sine * yrad;
	var y2 = y_int - sine * xoff + cosine * yrad;
	
	return collision_line(x1, y1, x2, y2, obj, true, false) != noone;
}