/// @description Render
var time = ctrlStage.stage_time;
var flash = image_index mod 16 < 8;
var _center_x = (CAMERA_WIDTH / 2);

// No HUD? No Nothing.
if (save_get_hud_style() == HUD.NONE) exit;

// Team Types
if (global.team_type != TEAM_TYPE.NONE)
{
	draw_sprite(sprHUDTeamType, global.team_type, 8, 1);
}

// Time
if (ctrlZone.is_hub == false)
{
	draw_sprite(sprHUDTime, 0, _center_x - 32, 5);
	var minutes = time div 3600;
	var seconds = (time div 60) mod 60;
	var centiseconds = floor(time / 0.6) mod 100;
}

// Lives
var lead_character_index = db_read(global.save_database, CHARACTER.NONE, "character", 0);
var partner_character_index = db_read(global.save_database, CHARACTER.NONE, "character", 1);
if (partner_character_index != CHARACTER.NONE)
{
    draw_sprite(sprLifeIcon, partner_character_index, 15, CAMERA_HEIGHT - 20);
}
if (lead_character_index != CHARACTER.NONE)
{
    draw_sprite(sprLifeIcon, lead_character_index, 5, CAMERA_HEIGHT - 19);
}

// Text
draw_set_font(global.font_hud);
draw_set_halign(fa_left);
var _lives_text = (global.lives > 9 ? "9" : (global.lives > 0 ? global.lives - 1 : "0"));
draw_text(32, CAMERA_HEIGHT - 17, _lives_text);
//draw_text(112, 9, global.score);
if (ctrlZone.is_hub == false)
{
	var _ring_hundreds = global.rings > 99 ? "" : "0";
	var _ring_tens = global.rings > 9 ? "" : "0";
	var _ring_text = string(_ring_hundreds) + string(_ring_tens) + string(global.rings);
	draw_text(36, 5, _ring_text);
	draw_text(_center_x - 14, 5, $"{minutes}");
	draw_text(_center_x - 2, 5, $"{seconds < 10 ? 0 : ""}{seconds}");
	draw_text(_center_x + 20, 5, $"{centiseconds < 10 ? 0 : ""}{centiseconds}");
}

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */