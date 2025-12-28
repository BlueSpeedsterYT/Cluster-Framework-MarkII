/// @description Update Item Box

#region States (Advance Item Boxes Only)

if (item_frames > 0)
{
    --item_frames;
}
	
switch (item_display_state)
{
    case 1:
    {
        if (item_frames <= 0)
        {
            objPlayer.player_obtain_item(index);
            item_frames = 30;
            item_display_state++;
        }
        else
        {
            icon_offset += -1;
        }
        break;
    }
    	
    case 2:
    {
        if (item_frames <= 0)
        {
            instance_destroy();
        }
        break;
    }
}

#endregion

//Check if the Item Box Icons are from the Advance era
var _is_advance_item_icon = (item_icon == ITEMBOX_ICON.ADVANCE_2 or item_icon == ITEMBOX_ICON.ADVANCE_3);

//Update Item Index/Icons
switch (index)
{
    case ITEM.LIFE:
    {
        if (LIVES_ENABLED)
        {
            //Only show per-character icons if not on the generic icons type
            if (_is_advance_item_icon)
            {
                //If the player character is internally listed as none or is beyond Cream, default to Sonic
                var chara_index = objPlayer.character_index;
                if (chara_index >= CHARACTER.SONIC and chara_index <= CHARACTER.CREAM)
                {
                    icon_display = chara_index;
                }
                else
                {
                    icon_display = 0;
                }
            }
            else
            {
                //Only show a generic 1Up icon from Rush onwards instead.
                //(except for Colors DS as Sonic is the only playable character there)
                icon_display = 0;
            }
        }
        else
        {
            //If the lives system is disabled, replace the 1Ups available with Rings
            index = choose(ITEM.RANDOM_RING_BONUS, ITEM.RING_BONUS, ITEM.SUPER_RING_BONUS);
        }
        break;
    }
    
    default:
    {
        //Offset the item icons by the last character listed (Cream) or by the index depending on item icons
        icon_display = (_is_advance_item_icon) ? index + CHARACTER.CREAM : index;
        break;
    }
}