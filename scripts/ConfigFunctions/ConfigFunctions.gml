function config_get(database_name, database_default)
{
	return db_read(global.config_database, database_default, database_name);
}

function config_set(database_name, database_value)
{
	db_write(global.config_database, database_value, database_name);
}

function config_reset()
{
	config_reset_audio();
	
	config_reset_advance();
	config_reset_misc();
}

function config_reset_audio()
{
	config_set("audio_sfx", 0.85);
	config_set("audio_bgm", 0.75);
}

function config_reset_advance()
{
	config_set("advance_turn", true);
	config_set("advance_brake", true);
	config_set("advance_hurt", true);
	config_set("advance_flicker", false);
}

function config_reset_misc()
{
	config_set("misc_hud", HUD.ADVANCE_2);
}

