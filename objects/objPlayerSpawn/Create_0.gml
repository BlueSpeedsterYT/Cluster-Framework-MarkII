/// @description Initialize
var player_objects = [objSonic, objMiles, objKnuckles, objAmy, objCream];
var character_enum_id = [CHARACTER.SONIC, CHARACTER.MILES, CHARACTER.KNUCKLES, CHARACTER.AMY, CHARACTER.CREAM];
global.players = array_create(INPUT_MAX_PLAYERS, noone);
global.characters = array_create(INPUT_MAX_PLAYERS, noone);
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    var character_index = db_read(global.save_database, CHARACTER.NONE, "character", i);
    if (character_index != CHARACTER.NONE)
    {
        var player_inst = instance_create_depth(x - 32 * i, y, DEPTH_PLAYER + i, player_objects[character_index]);
        var character_name = character_enum_id[character_index];
        with (player_inst) player_index = i;
        array_set(global.players, i, player_inst);
        array_set(global.characters, i, character_name);
    }
}

if (global.characters[0] == CHARACTER.SONIC || global.characters[1] == CHARACTER.SONIC)
{
	global.team_type = TEAM_TYPE.SPEED;
}
else if (global.characters[0] == CHARACTER.KNUCKLES || global.characters[1] == CHARACTER.KNUCKLES)
{
	global.team_type = TEAM_TYPE.POWER;
}
else
{
	global.team_type = TEAM_TYPE.FLY;
}

global.players[0].camera = global.main_camera;
instance_destroy();