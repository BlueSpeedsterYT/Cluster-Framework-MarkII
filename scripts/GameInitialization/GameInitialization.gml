// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro DEPTH_OFFSET_AFTERIMAGE 25
#macro DEPTH_OFFSET_PLAYER 50
#macro DEPTH_OFFSET_PARTICLE 75

enum CHARACTER
{
    NONE = -1,
    SONIC,
    MILES,
    KNUCKLES,
    AMY,
    CREAM
}

enum HUD
{
    NONE,
    CLUSTER_GM8,
    S4_EPISODE_II,
    ADVANCE_2
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

// Music
audio_loop_points(bgmExtraBattle1, 14.2224, 128.0002);
audio_loop_points(bgmR99Map, (143360/44100), (1740820/44100));

// Player values
global.players = -1;
global.characters = -1;
global.score = 0;
global.lives = 3;
global.rings = 0;

// Fonts
global.font_hud_sa2 = font_add_sprite(sprHUDFontSA2, ord("0"), false, 0);

// Misc.
surface_depth_disable(true);
randomize();
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, false, INPUT_VERB.CANCEL, undefined);

// Create global controllers
call_later(1, time_source_units_frames, function()
{
	instance_create_layer(0, 0, "Controllers", ctrlWindow);
	instance_create_layer(0, 0, "Controllers", ctrlMusic);
});

/* AUTHOR NOTE: this must be done one frame later as the first room will not have loaded yet. */