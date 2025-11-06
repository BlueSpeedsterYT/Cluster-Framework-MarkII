// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro DEPTH_AFTERIMAGE 75 
#macro DEPTH_PLAYER 50
#macro DEPTH_PARTICLE 25

enum CHARACTER
{
    NONE = -1,
    SONIC,
    MILES,
    KNUCKLES,
    AMY,
    CREAM
}

enum TEAM_TYPE
{
    NONE = -1,
    SPEED,
    POWER,
    FLY
}

enum ANGLE
{
    UP = 90,
    DOWN = 270,
    LEFT = 180,
    RIGHT = 0,
    LEFT_UP = 135,
    LEFT_DOWN = 225,
    RIGHT_UP = 45,
    RIGHT_DOWN = 315
}

// Volumes
global.volume_sound = 1;
global.volume_music = 1;

// Player values
global.players = -1;
global.characters = -1;
global.team_type = TEAM_TYPE.NONE;
global.score = 0;
global.lives = 3;
global.rings = 0;

// Fonts
global.font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 0);

// Misc.
surface_depth_disable(true);
randomize();
audio_channel_num(16);
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, false, INPUT_VERB.CANCEL, undefined);

// Create global controllers
call_later(1, time_source_units_frames, function()
{
	instance_create_layer(0, 0, "Controllers", ctrlWindow);
	instance_create_layer(0, 0, "Controllers", ctrlMusic);
});

/* AUTHOR NOTE: this must be done one frame later as the first room will not have loaded yet. */