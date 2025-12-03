function save_get(database_name, database_default)
{
	return db_read(global.save_database, database_default, database_name);
}

function save_set(database_name, database_value)
{
	db_write(global.save_database, database_value, database_name);
}

function save_reset()
{
	save_set("name", "");
	save_set("playtime", 0);
	save_set("stage", room_get_name(rmTest));

	save_reset_character();
	
	save_set("boost", false);
	save_set("trick", true);
	save_set("tag", false);
	save_set("swap", false);
}

function save_get_character(chara_id = 0)
{
	return db_read(global.save_database, CHARACTER.NONE, "character", chara_id);
}

function save_set_character(chara_set = CHARACTER.SONIC, chara_id = 0)
{
	db_write(global.save_database, chara_set, "character", chara_id);
}

function save_reset_character()
{
	for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
	{
	    save_set_character(CHARACTER.NONE, i);
	}

	save_set_character(CHARACTER.SONIC, 0);
}