/// @function player_collision(obj)
/// @description Checks if the given entity's mask intersects the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @returns {Bool}
function player_collision(obj)
{
	return box_collision(obj, x_radius, y_radius, (mask_direction mod 180 != 0))
}

/// @function player_part_collision(obj, xrad, ylen)
/// @description Checks if the given entity's mask intersects a vertical portion of the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} xrad Distance in pixels to extend the player's mask horizontally.
/// @param {Real} ylen Distance in pixels to extend the line downward.
/// @returns {Bool}
function player_part_collision(obj, xrad, ylen)
{
	return part_collision(obj, mask_direction, xrad, ylen);
}

/// @function player_beam_collision(obj, [xdia], [yoff])
/// @description Checks if the given entity's mask intersects a line from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} [xdia] Distance in pixels to extend the line horizontally on both ends (optional, default is the player's wall radius).
/// @param {Real} [yoff] Distance in pixels to offset the line vertically (optional, default is 0).
/// @returns {Bool}
function player_beam_collision(obj, xdia = x_wall_radius, yoff = 0)
{
	return beam_collision(obj, mask_direction, xdia, yoff);
}

/// @function player_ray_collision(obj, xoff, yrad)
/// @description Checks if the given entity's mask intersects a line from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} xoff Distance in pixels to offset the line horizontally.
/// @param {Real} yrad Distance in pixels to extend the line downward.
/// @returns {Bool}
function player_ray_collision(obj, xoff, yrad)
{
	return ray_collision(obj, mask_direction, xoff, yrad);
}