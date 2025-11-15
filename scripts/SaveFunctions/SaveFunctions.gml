function save_get_character(chara_id = 0)
{
	return db_read(global.save_database, CHARACTER.NONE, "character", chara_id);
}

function save_set_character(chara_set = CHARACTER.SONIC, chara_id = 0)
{
	db_write(global.save_database, chara_set, "character", chara_id);
}

function save_get_hud_style()
{
	return db_read(global.save_database, HUD.ADVANCE_3, "hud_type");
}

function save_set_hud_style(hud_set = HUD.ADVANCE_3)
{
	db_write(global.save_database, hud_set, "hud_type");
}