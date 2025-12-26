/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-12, -13, 12, 13);

item_icon = db_read(global.config_database, ITEMBOX_ICON.ADVANCE_2, "itembox_icon");
item_design = db_read(global.config_database, ITEMBOX_DESIGN.ADVANCE_2, "itembox_design");

switch (item_icon)
{
	case ITEMBOX_ICON.ADVANCE_2: icon_sprite = sprItemIconAdvance2; break;
	case ITEMBOX_ICON.ADVANCE_3: icon_sprite = sprItemIconAdvance3; break;
}

switch (item_design)
{
	case ITEMBOX_DESIGN.ADVANCE: itembox_sprite = sprItemBoxAdvance; break;
	case ITEMBOX_DESIGN.ADVANCE_2: itembox_sprite = sprItemBoxAdvance2; break;
}

item_delay = 0;
icon_display = 0;
icon_offset = 0;

enum ITEMS
{
    ONE_UP,
    BASIC_SHIELD,
    MAGNETIC_SHIELD,
    //There used to be some Elemental Shields here... but they're gone now...
    INVINCIBILITY,
    SUPER_SPEED,
    BONUS_RANDOM_RINGS,
    BONUS_5_RINGS,
    BONUS_10_RINGS
    //There used to be some Multiplayer items here... but they're gone now...
}

reaction = function(pla)
{
	if (collision_player(0, pla) and pla.state != player_is_dead)
	{
		if (pla.player_index == 0 or (pla.player_index != 0 and pla.cpu_gamepad_time > 0))
		{
			//TODO: Call the Sonic Homing Routine here once added
			//pla.player_give_item(pla, item_index);
			//particle_create(x, y, global.ani_ring_sparkle_v0);
			instance_destroy();
		}
	}
}