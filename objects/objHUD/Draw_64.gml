/// @description Render
var time = ctrlStage.stage_time;
var reached_time_limit = time == ctrlStage.time_limit;
var minutes = time div 3600;
var seconds = (time div 60) mod 60;
var centiseconds = floor(time / 0.6) mod 100;

// Switch up HUD styles:
/*
switch (config_get("misc_hud"))
{
	case HUD.S4_EPISODE_2:
	{
		var _flash = mod_time(time, 8, 2);
		
		hud_x = 13;
		hud_y = 14;
		
		if (ctrlStage.is_hub == false)
		{
			// Main HUD Sprite
			draw_sprite(sprHUDS4E2, 0, hud_x, hud_y);
		
			// Main Text Stuff
			draw_set_halign(fa_left);
			draw_set_color(c_white);
		
			// Score Text
			draw_set_font(global.font_hud_score_s4e2);
			draw_text(hud_x + 37, hud_y + 3, string_pad(global.score, 9));
			
			// Time Text
			var _time_x = hud_x + 58;
			var _time_y = hud_y + 18;
			draw_set_font(global.font_hud_time_s4e2);
			draw_text(_time_x, _time_y, $"{reached_time_limit ? "9" : minutes}");
			draw_text(_time_x + 10, _time_y, ":");
			draw_text(_time_x + 16, _time_y, reached_time_limit ? "59" : string_pad(seconds, 2));
			draw_text(_time_x + 35, _time_y, ";");
			draw_text(_time_x + 44, _time_y, reached_time_limit ? "99" : string_pad(centiseconds, 2));
			
			// Ring Text
			draw_set_font(global.font_hud_s4e2);
			if ((_flash and global.rings == 0) || global.rings > 0)
			{
			    if (global.rings == 0) draw_set_color(c_red);
			    draw_text(hud_x - 5, hud_y + 11, string_pad(global.rings, 3));
			}
		}
		break;
	}
	
	case HUD.ADVANCE_2:
	{
*/
		var _center_x = (CAMERA_WIDTH / 2);
		var _flash = (time & 0x10);

		hud_x = 0;
		hud_y = 3;

		// Lives
		//var lead_character_index = save_get_character(0);
		//if (lead_character_index != CHARACTER.NONE)
		//{
		    //draw_sprite(sprLifeIconSA2, lead_character_index, hud_x + 6, CAMERA_HEIGHT - 20);
		//}

		// Text
		draw_set_font(global.font_hud_sa2);
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		//var _lives_text = (global.lives > 9 ? "9" : (global.lives > 0 ? global.lives - 1 : "0"));
		//draw_text(hud_x + 30, CAMERA_HEIGHT - 17, _lives_text);
		if (ctrlStage.is_hub == false)
		{
			// Draw Score
			var _score_text = global.score > 999999 ? "999999" : string_pad(global.score, 6)
			draw_text(hud_x + 28, hud_y + 14, _score_text);
			
			// Draw Rings
			draw_sprite(sprHUDRingContainerSA2, 0, hud_x + 1, hud_y);
			sa2_ring_current_frame += (abs(objPlayer.x_speed) / 8) + 0.25;
			sa2_ring_final_frame = (sa2_ring_current_frame mod 256);
			draw_sprite(sprHUDRingSA2, sa2_ring_final_frame, hud_x + 7, hud_y + 5);
			draw_set_colour(_flash and global.rings == 0 ? c_red : c_white);
			draw_text(hud_x + 28, hud_y, string_pad(global.rings, 3));
			draw_set_colour(c_white);
			
			// Draw Timer
			draw_sprite(sprHUDColonSA2, 0, hud_x + _center_x - 20, hud_y);
			draw_sprite(sprHUDColonSA2, 0, hud_x + _center_x + 4, hud_y);
			draw_set_colour(_flash and minutes >= 9 ? c_red : c_white);
			draw_text(hud_x + _center_x - 28, hud_y, $"{reached_time_limit ? "9" : minutes}");
			draw_text(hud_x + _center_x - 12, hud_y, reached_time_limit ? "59" : string_pad(seconds, 2));
			draw_text(hud_x + _center_x + 12, hud_y, reached_time_limit ? "99" : string_pad(centiseconds, 2));
			draw_set_colour(c_white);
		}
/*
		break;
	}
}
*/

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */