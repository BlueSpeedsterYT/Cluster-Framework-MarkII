/// @description Draw Item Box
var x_int = x div 1;
var y_int = y div 1;

var item_icon_offset = y_int + icon_offset;

draw_sprite_ext(icon_sprite, icon_display, x_int, item_icon_offset, 1, 1, image_angle, c_white, 1);
draw_sprite_ext(itembox_sprite, 0, x_int, y_int, 1, 1, image_angle, c_white, 1);