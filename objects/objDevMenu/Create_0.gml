/// @description Setup
image_speed = 0;
history = [];

#region Gameplay

boost_option = new dev_option_bool("Boost");
boost_option.get = function() { return db_read(global.save_database, true, "boost"); };
boost_option.set = function(val) { db_write(global.save_database, val, "boost"); };

trick_option = new dev_option_bool("Trick");
trick_option.get = function() { return db_read(global.save_database, true, "trick"); };
trick_option.set = function(val) { db_write(global.save_database, val, "trick"); };

tag_option = new dev_option_bool("Tag");
tag_option.get = function() { return db_read(global.save_database, true, "tag"); };
tag_option.set = function(val) { db_write(global.save_database, val, "tag"); };

swap_option = new dev_option_bool("Swap");
swap_option.get = function() { return db_read(global.save_database, true, "swap"); };
swap_option.set = function(val) { db_write(global.save_database, val, "swap"); };

gameplay_menu = new dev_menu([boost_option, trick_option, tag_option, swap_option]);

#endregion

#region Config

lives_option = new dev_option_bool("Lives");
lives_option.get = function() { return db_read(global.config_database, true, "lives"); };
lives_option.set = function(val) { db_write(global.config_database, val, "lives"); };

time_over_option = new dev_option_bool("Time Over");
time_over_option.get = function() { return db_read(global.config_database, true, "time_over"); };
time_over_option.set = function(val) { db_write(global.config_database, val, "time_over"); };

random_ring_option = new dev_option_int("Random Ring");
random_ring_option.get = function() { return db_read(global.config_database, RANDOM_RING.ADVANCE, "random_ring"); };
random_ring_option.set = function(val) { db_write(global.config_database, val, "random_ring"); };
random_ring_option.clampinv = true;
random_ring_option.minimum = RANDOM_RING.HYBRID;
random_ring_option.maximum = RANDOM_RING.ADVANCE_2;
random_ring_option.specifiers = ["Hybrid", "Advance", "Advance 2"];
random_ring_option.offset = RANDOM_RING.HYBRID;

itembox_icon_option = new dev_option_int("Item Box Icon");
itembox_icon_option.get = function() { return db_read(global.config_database, ITEMBOX_ICON.CLUSTER, "itembox_icon"); };
itembox_icon_option.set = function(val) { db_write(global.config_database, val, "itembox_icon"); };
itembox_icon_option.clampinv = true;
itembox_icon_option.minimum = ITEMBOX_ICON.GENERIC;
itembox_icon_option.maximum = ITEMBOX_ICON.ADVANCE_3;
itembox_icon_option.specifiers = ["Generic", "Cluster", "Advance 2", "Advance 3"];
itembox_icon_option.offset = ITEMBOX_ICON.GENERIC;

itembox_design_option = new dev_option_int("Item Box Design");
itembox_design_option.get = function() { return db_read(global.config_database, ITEMBOX_DESIGN.CLUSTER, "itembox_design"); };
itembox_design_option.set = function(val) { db_write(global.config_database, val, "itembox_design"); };
itembox_design_option.clampinv = true;
itembox_design_option.minimum = ITEMBOX_DESIGN.CLUSTER;
itembox_design_option.maximum = ITEMBOX_DESIGN.COLORS_DS;
itembox_design_option.specifiers = ["Cluster", "Advance", "Advance 2", "Rush", "Rush Adventure", "Colors (DS)"];
itembox_design_option.offset = ITEMBOX_DESIGN.CLUSTER;

hud_option = new dev_option_int("HUD");
hud_option.get = function() { return db_read(global.config_database, HUD.CLUSTER, "hud"); };
hud_option.set = function(val) { db_write(global.config_database, val, "hud"); };
hud_option.clampinv = true;
hud_option.minimum = HUD.NONE;
hud_option.maximum = HUD.EPISODE_II;
hud_option.specifiers = ["None", "Cluster", "Adventure", "Adventure 2", "Advance 2", "Advance 3", "Episode II"];
hud_option.offset = HUD.NONE;

flicker_option = new dev_option_int("Flicker");
flicker_option.get = function() { return db_read(global.config_database, FLICKER.OFF, "flicker"); };
flicker_option.set = function(val) { db_write(global.config_database, val, "flicker"); };
flicker_option.clampinv = true;
flicker_option.minimum = FLICKER.OFF;
flicker_option.maximum = FLICKER.VIRTUAL_CONSOLE_ADVANCE_3;
flicker_option.specifiers = ["Off", "Original", "Virtual Console", "Virtual Console (Advance 3)"];

device_option = new dev_option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

config_menu = new dev_menu([lives_option, time_over_option, random_ring_option, itembox_icon_option, itembox_design_option, hud_option, flicker_option, device_option]);

#endregion

#region Room

test_old_option = new dev_option("Old Test Room");
test_old_option.confirm = function()
{
    room_goto(rmTest);
    return true;
};

test_option = new dev_option("Test Room");
test_option.confirm = function()
{
    room_goto(rmTestNew);
    return true;
};

room_menu = new dev_menu([test_old_option, test_option]);

#endregion

#region Home

player_0_option = new dev_option_player(0);
player_1_option = new dev_option_player(1);

gameplay_option = new dev_option("Gameplay");
gameplay_option.confirm = function() { dev_menu_goto(gameplay_menu); }

config_option = new dev_option("Config");
config_option.confirm = function() { dev_menu_goto(config_menu); }

room_option = new dev_option("Room");
room_option.confirm = function() { dev_menu_goto(room_menu); }

home_menu = new dev_menu([player_0_option, player_1_option, gameplay_option, config_option, room_option]);

#endregion

current_menu = home_menu;