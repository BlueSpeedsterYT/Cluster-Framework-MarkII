/// @description Render
var time = ctrlStage.stage_time;
var flash = image_index mod 16 < 8;

// Time:
if (ctrlStage.is_hub == false)
{
	var minutes = time div 3600;
	var seconds = (time div 60) mod 60;
	var centiseconds = floor(time / 0.6) mod 100;
}

// Switch up HUD styles:
switch (config_get("misc_hud", HUD.CLUSTER_GM8))
{
	case HUD.ADVANCE_2:
	{
		var _center_x = (CAMERA_WIDTH / 2);

		// Lives
		var lead_character_index = save_get_character(0);
		if (lead_character_index != CHARACTER.NONE)
		{
		    draw_sprite(sprLifeIconSA2, lead_character_index, 6, CAMERA_HEIGHT - 20);
		}

		// Text
		draw_set_font(global.font_hud_sa2);
		draw_set_halign(fa_left);
		var _lives_text = (global.lives > 9 ? "9" : (global.lives > 0 ? global.lives - 1 : "0"));
		draw_text(30, CAMERA_HEIGHT - 17, _lives_text);
		if (ctrlStage.is_hub == false)
		{
			// Draw Score
			var _score_hundred_thousands = global.score > 99999 ? "" : "0";
			var _score_ten_thousands = global.score > 9999 ? "" : "0";
			var _score_thousands = global.score > 999 ? "" : "0";
			var _score_hundreds = global.score > 99 ? "" : "0";
			var _score_tens = global.score > 9 ? "" : "0";
			var _score_text = $"{_score_hundred_thousands}{_score_ten_thousands}{_score_thousands}{_score_hundreds}{_score_tens}{global.score}";
			draw_text(28, 17, _score_text);
			
			// Draw Rings
			draw_sprite(sprHUDRingContainerSA2, 0, 1, 3);
			var _ring_hundreds = global.rings > 99 ? "" : "0";
			var _ring_tens = global.rings > 9 ? "" : "0";
			var _ring_text = $"{_ring_hundreds}{_ring_tens}{global.rings}";
			draw_text(28, 3, _ring_text);
			
			// Draw Timer
			draw_sprite(sprHUDColonSA2, 0, _center_x - 20, 3);
			draw_sprite(sprHUDColonSA2, 0, _center_x + 4, 3);
			draw_text(_center_x - 28, 3, $"{minutes}");
			draw_text(_center_x - 12, 3, $"{seconds < 10 ? 0 : ""}{seconds}");
			draw_text(_center_x + 12, 3, $"{centiseconds < 10 ? 0 : ""}{centiseconds}");
		}
		break;
	}
}
/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */