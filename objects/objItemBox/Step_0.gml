/// @description Update Item Box

switch (item_index)
{
	case ITEMS.ONE_UP:
	{
		if (LIVES_ENABLED)
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
			//If the lives system is disabled, replace the one-ups available with Rings
			item_index = choose(ITEMS.BONUS_RANDOM_RINGS, ITEMS.BONUS_5_RINGS, ITEMS.BONUS_10_RINGS);
		}
		break;
	}
	
	default:
	{
		//Offset the item icons by the last character listed (Cream)
		icon_display = item_index + CHARACTER.CREAM;
	}
}