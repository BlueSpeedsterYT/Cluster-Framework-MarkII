/// @description Setup
// Inherit the parent event
event_inherited();

item_icon = db_read(global.config_database, ITEMBOX_ICON.ADVANCE_2, "itembox_icon");
item_design = db_read(global.config_database, ITEMBOX_DESIGN.ADVANCE_2, "itembox_design");

switch (item_icon)
{
    case ITEMBOX_ICON.CLUSTER: icon_sprite = sprItemIcon; break;
    case ITEMBOX_ICON.GENERIC: icon_sprite = sprItemIconGeneric; break;
    case ITEMBOX_ICON.ADVANCE_2: icon_sprite = sprItemIconAdvance2; break;
    case ITEMBOX_ICON.ADVANCE_3: icon_sprite = sprItemIconAdvance3; break;
}

switch (item_design)
{
    case ITEMBOX_DESIGN.CLUSTER:
    {
        hitboxes[0].set_size(-15, -17, 15, 15);
        itembox_sprite = sprItemBox;
        break;
    }
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

reaction = function(pla)
{
    // Abort if broken or player is a cpu
    if ((item_design == ITEMBOX_DESIGN.CLUSTER and image_index != 0) or item_display_state > 0 or pla.player_index != 0) exit;

    if (collision_player(0, pla) or collision_player(0, pla, 0) or collision_player(0, pla, 1))
    {
        if (not pla.on_ground and pla.y_speed > 0) pla.y_speed = -(pla.y_speed + 2 * pla.gravity_force);
        if (item_design == ITEMBOX_DESIGN.CLUSTER or item_design >= ITEMBOX_DESIGN.RUSH)
        {
            pla.player_obtain_item(index);
        }
        else
        {
            draw_itembox = false;
            hitboxes[0].set_size(0, 0, 0, 0);
            item_frames = 60;
            item_display_state++;
        }
        audio_play_single(sfxDestroy);
        particle_create(x, y + 15, global.ani_explosion_enemy_v0);
        if (item_design == ITEMBOX_DESIGN.CLUSTER or item_design >= ITEMBOX_DESIGN.RUSH)
        {
            if (item_design == ITEMBOX_DESIGN.CLUSTER) image_index = 1;
            instance_destroy();
        }
    }
}