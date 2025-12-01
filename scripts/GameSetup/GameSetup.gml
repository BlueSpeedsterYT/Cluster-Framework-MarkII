// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro MUTE_MUSIC 1
#macro MUTE_JINGLE 2
#macro MUTE_DROWN 4

#macro PRIORITY_SOUND 0 
#macro PRIORITY_MUSIC 1
#macro PRIORITY_JINGLE 2
#macro PRIORITY_DROWN 3 

#macro DEPTH_OFFSET_AFTERIMAGE 25
#macro DEPTH_OFFSET_PLAYER 50
#macro DEPTH_OFFSET_PARTICLE 75

#macro COLL_FLAG_TOP 0x10000
#macro COLL_FLAG_BOTTOM 0x20000
#macro COLL_FLAG_RIGHT 0x40000
#macro COLL_FLAG_LEFT 0x80000
#macro COLL_FLAG_VERTICAL 0x30000
#macro COLL_FLAG_HORIZONTAL 0xC0000

#macro PLAYER_HEIGHT 14

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

enum PHASE
{ 
    ENTER,
    STEP,
    EXIT
}

enum PLAYER_ANIMATION
{ 
    IDLE,
    TEETER,
    TURN,
    RUN,
    BRAKE,
    LOOK,
    CROUCH,
    ROLL,
    SPIN_DASH,
    FALL,
    JUMP,
    HURT,
    DEAD,
    TRICK_UP,
    TRICK_DOWN,
    TRICK_FRONT,
    TRICK_BACK,
    SPRING,
    SPRING_TWIRL
}

enum SHIELD_TYPE
{ 
    NONE,
    BASIC,
    MAGNETIC,
    BUBBLE,
    FIRE,
    LIGHTNING
}

enum STATUS_INDEX
{ 
    SHIELD,
    INVINCIBILITY,
    SPEED,
    PANIC,
    SWAP,
    TOTAL_STATUSES
}

enum TRICK
{
	UP,
	DOWN,
	FRONT,
	BACK
}

enum CPU_INPUT
{
	X,
	Y,
	JUMP,
	JUMP_PRESSED,
	MAX
}

enum CPU_STATE
{
	FOLLOW,
	CROUCH,
	SPIN_DASH
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
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, false, INPUT_VERB.CANCEL, undefined);
randomize();

// Create global controllers
call_later(1, time_source_units_frames, function()
{
	instance_create_layer(0, 0, "Controllers", ctrlWindow);
	instance_create_layer(0, 0, "Controllers", ctrlMusic);
});

/* AUTHOR NOTE: this must be done one frame later as the first room will not have loaded yet. */