/// @description Draw Item Box
var x_int = x div 1;
var y_int = y div 1;

var item_icon_offset = y_int + icon_offset;


if (item_design != ITEMBOX_DESIGN.RUSH)
{
	var rush_adventure_x_offset, rush_adventure_y_offset;
	rush_adventure_x_offset = item_design == ITEMBOX_DESIGN.RUSH_ADVENTURE ? 1 : 0;
	rush_adventure_y_offset = item_design == ITEMBOX_DESIGN.RUSH_ADVENTURE ? 3 : 0;
	draw_sprite_ext(icon_sprite, icon_display, x_int + rush_adventure_x_offset, item_icon_offset - rush_adventure_y_offset, 1, 1, image_angle, c_white, 1);
}

if (draw_itembox)
{
	draw_sprite_ext(itembox_sprite, 0, x_int, y_int, 1, 1, image_angle, c_white, 1);
}

if (item_design == ITEMBOX_DESIGN.RUSH)
{
	draw_sprite_ext(icon_sprite, icon_display, x_int, item_icon_offset - 3, 1, 1, image_angle, c_white, 1);
}