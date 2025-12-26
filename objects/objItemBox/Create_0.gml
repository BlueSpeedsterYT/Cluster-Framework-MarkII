/// @description Setup
// Inherit the parent event
event_inherited();

item_icon = db_read(global.config_database, ITEMBOX_ICON.ADVANCE_2, "itembox_icon");
item_design = db_read(global.config_database, ITEMBOX_DESIGN.ADVANCE_2, "itembox_design");

switch (item_icon)
{
	case ITEMBOX_ICON.GENERIC: icon_sprite = sprItemIconGeneric; break;
	case ITEMBOX_ICON.ADVANCE_2: icon_sprite = sprItemIconAdvance2; break;
	case ITEMBOX_ICON.ADVANCE_3: icon_sprite = sprItemIconAdvance3; break;
}

switch (item_design)
{
	case ITEMBOX_DESIGN.ADVANCE:
	case ITEMBOX_DESIGN.ADVANCE_2:
	{
		hitboxes[0].set_size(-12, -13, 12, 13);
		itembox_sprite = item_design == ITEMBOX_DESIGN.ADVANCE ? sprItemBoxAdvance : sprItemBoxAdvance2; 
		break;
	}
	case ITEMBOX_DESIGN.RUSH:
	{
		hitboxes[0].set_size(-9, -15, 13, 15);
		itembox_sprite = sprItemBoxRush;
		break;
	}
	case ITEMBOX_DESIGN.RUSH_ADVENTURE:
	{
		hitboxes[0].set_size(-10, -13, 13, 11);
		itembox_sprite = sprItemBoxRushAdventure;
		break;
	}
	case ITEMBOX_DESIGN.COLORS_DS:
	{
		hitboxes[0].set_size(-11, -13, 11, 13);
		itembox_sprite = sprItemBoxColorsDS; 
		break;
	}
}

item_display_state = 0; 
item_frames = 0;
draw_itembox = true;
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
	if (item_display_state > 0) exit;
	
	/* AUTHOR NOTE:
	(1) Find out if the Rush Item Box has solid collision in any capacity.
	(2) Improve the Advance Item Box icon behavior. */
	if (collision_player(0, pla) and pla.state != player_is_dead)
	{
		if (pla.player_index == 0 or (pla.player_index != 0 and pla.cpu_gamepad_time > 0))
		{
			//TODO: Make this work while grounded
			//NOTE: Maybe check the Rush games if this behavior was retained?
			if (player_break_recoil or not pla.on_ground)
			{
				pla.y_speed = -3;
			}
			
			//TODO: Call the Sonic Homing Routine here once added
			if (item_design >= ITEMBOX_DESIGN.RUSH) //Give the item immediately if we're beyond the Advance games
			{
				pla.player_give_item(item_index);
				instance_destroy();
			}
			else //Otherwise, make it behave like SA2
			{
				draw_itembox = false;
				hitboxes[0].set_size(0, 0, 0, 0);
				item_frames = 60;
				item_display_state++;
			}
			//particle_create(x, y, global.ani_ring_sparkle_v0);
		}
	}
}