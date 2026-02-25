/// @description Render
var time = ctrlGame.game_time;
var cam_x = camera_get_view_x(CAMERA_ID);
var cam_y = camera_get_view_y(CAMERA_ID);

draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (time >> 4), 0, cam_x, cam_y, CAMERA_WIDTH, 8);
draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (time >> 5), 8, cam_x, cam_y + 8, CAMERA_WIDTH, 16);
draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (time >> 6), 24, cam_x, cam_y + 24, CAMERA_WIDTH, 16);
draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, 0, 40, cam_x, cam_y + 40, CAMERA_WIDTH, 48);
for (var i = 88; i < 160; i++)
{
    draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (i - 86) * cam_x div 256, i, cam_x, cam_y + i, CAMERA_WIDTH, 1);
}