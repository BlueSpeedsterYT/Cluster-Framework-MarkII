// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro DEPTH_OFFSET_AFTERIMAGE 25
#macro DEPTH_OFFSET_PLAYER 50
#macro DEPTH_OFFSET_PARTICLE 75

#macro COLL_ANY 0xC0000
#macro COLL_TOP 0x10000
#macro COLL_BOTTOM 0x20000
#macro COLL_RIGHT 0x40000
#macro COLL_LEFT 0x80000
#macro COLL_VERTICAL 0x30000

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
    S4_EPISODE_2,
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
global.volume_sound = config_get("audio_sfx", 0.85);
global.volume_music = config_get("audio_bgm", 0.75);

// Music
audio_loop_points(bgmExtraBattle1, 14.2224, 128.0002);
audio_loop_points(bgmR99Map, (143360/44100), (1740820/44100));

// Player values
global.players = -1;
global.characters = -1;
global.score = 0;
//global.lives = 3;
global.rings = 0;

// Fonts
global.font_hud_sa2 = font_add_sprite(sprHUDFontSA2, ord("0"), false, 0);
global.font_hud_s4e2 = font_add_sprite(sprHUDFontRingS4E2, ord("0"), false, 1);
global.font_hud_score_s4e2 = font_add_sprite(sprHUDFontScoreS4E2, ord("0"), false, 1);
global.font_hud_time_s4e2 = font_add_sprite_ext(sprHUDFontTimeS4E2, "0123456789:;", false, 1);

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