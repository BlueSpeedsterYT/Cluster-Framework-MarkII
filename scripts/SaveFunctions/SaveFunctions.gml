function save_reset()
{
    db_write(global.save_database, "name", "");
    db_write(global.save_database, "playtime", 0);
    db_write(global.save_database, "stage", room_get_name(rmTest));
    
    for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        db_write(global.save_database, CHARACTER.NONE, "character", i);
    }
    
    db_write(global.save_database, CHARACTER.SONIC, "character", 0);
    
    db_write(global.save_database, "boost", false);
    db_write(global.save_database, "trick", true);
    db_write(global.save_database, "tag", false);
    db_write(global.save_database, "swap", false);
}