// Constants
enum HUD
{
    NONE = -1,
    CLUSTER,
    ADVENTURE,
    ADVENTURE_2,
    ADVANCE_2,
    ADVANCE_3,
    EPISODE_II
}

enum FLICKER
{
    OFF,
    ORIGINAL,
    VIRTUAL_CONSOLE,
    VIRTUAL_CONSOLE_ADVANCE_3
}

enum RANDOM_RING
{
    HYBRID,
    ADVANCE,
    ADVANCE_2
}

enum ITEMBOX_ICON
{
    GENERIC, //Makes the icons match like the Rush games
    CLUSTER,
    //ADVANCE, //No Cream the Rabbit icon for this design so it's out of the question
    ADVANCE_2,
    ADVANCE_3
}

enum ITEMBOX_DESIGN
{
    CLUSTER,
    ADVANCE,
    ADVANCE_2,
    //ADVANCE_3, //Design is the same between Advance 2 and 3
    RUSH,
    RUSH_ADVENTURE,
    COLORS_DS
}

global.config_database = db_create();
db_write(global.config_database, true, "lives");
db_write(global.config_database, true, "time_over");
db_write(global.config_database, RANDOM_RING.ADVANCE, "random_ring");
db_write(global.config_database, ITEMBOX_ICON.ADVANCE_2, "itembox_icon");
db_write(global.config_database, ITEMBOX_DESIGN.RUSH, "itembox_design");
db_write(global.config_database, HUD.CLUSTER, "hud");
db_write(global.config_database, FLICKER.OFF, "flicker");
