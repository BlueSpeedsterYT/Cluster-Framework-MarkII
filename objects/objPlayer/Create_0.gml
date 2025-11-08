/// @description Initialize
image_speed = 0;

// Constants
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
    SPRING,
    SPRING_TWIRL,
	PUSH,
	HURT,
	DEAD
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

#macro PLAYER_HEIGHT 14

// State machine
state = player_is_ready;
state_previous = -1;
state_changed = false;

jump_action = false;
jump_cap = true;

spin_dash_charge = 0;

// Timers
control_lock_time = 0;
superspeed_time = 0;
remaining_air_time = 0;
invincibility_time = 0;
invulnerability_time = 0;
camera_look_time = 0;

slide_duration = 30;
spring_duration = 16;
remaining_air_duration = 120;
invulnerability_duration = 120;

// Physics
underwater = false;
drown = false;
x_speed = 0;
y_speed = 0;

player_refresh_physics();

slide_threshold = 2.5;

air_drag_threshold = 0.125;
air_drag = 0.96875;

boost_mode = false;
boost_speed = 0;

// Collision detection
x_radius = 8;
x_wall_radius = 10;

y_radius = 15;
y_tile_reach = 16;

hitboxes[0] = new hitbox(c_maroon);
hitboxes[1] = new hitbox(c_green);

landed = false;
on_ground = true;
ground_snap = true;

direction = 0;
gravity_direction = 0;
local_direction = 0;
mask_direction = 0;

cliff_sign = 0;

tilemaps =
[
	layer_tilemap_get_id("TilesLayer0"),
	layer_tilemap_get_id("TilesLayer1"),
	layer_tilemap_get_id("TilesMain")
];

semisolid_tilemap = layer_tilemap_get_id("TilesSemisolid");

solid_objects = [];

// Per-Character Variables

// Homing Attack (TODO: Maybe move this to the Sonic object.)
homing_inst = noone;
homing_range = 128;
homing_speed = 12;
homing_time = 0;
homing_duration = 180;

// Input
input_axis_x = 0;
input_axis_y = 0;
input_allow = true;

/// @function button(verb)
/// @description Creates a new button.
/// @param {Enum.INPUT_VERB} verb Verb to check.
function button(_verb) constructor
{
    verb = _verb;
    check = false;
    pressed = false;
    released = false;
}

input_button =
{
    jump : new button(INPUT_VERB.JUMP),
    aux : new button(INPUT_VERB.AUX),
    swap : new button(INPUT_VERB.SWAP),
    extra : new button(INPUT_VERB.EXTRA),
    tag : new button(INPUT_VERB.ALT),
    alt : new button(INPUT_VERB.START),
    start : new button(INPUT_VERB.START),
    select : new button(INPUT_VERB.SELECT)
};

/// @method player_reset_input()
/// @description Resets all player input.
player_reset_input = function()
{
	input_axis_x = 0;
	input_axis_y = 0;
	
	struct_foreach(input_button, function(name, value)
	{
	    var verb = value.verb;
	    value.check = false;
	    value.pressed = false;
	    value.released = false;
	});
};

// CPU
input_cpu_state = 0;
input_cpu_state_time = 0;
input_cpu_respawn_time = 0;
input_cpu_gamepad_time = 0;
input_cpu_respawn_duration = 300;
input_cpu_gamepad_duration = 600;
input_cpu_history = array_create(CPU_INPUT.MAX);
for (var i = 0; i < CPU_INPUT.MAX; i++) input_cpu_history[i] = array_create(16);

/// @method player_record_cpu_input(cpu_input)
/// @description Records the given CPU input.
/// @param {Enum.CPU_INPUT} CPU input to record.
player_record_cpu_input = function(cpu_input)
{
	var input;
	switch (cpu_input)
	{
		case CPU_INPUT.X:
		{
			input = input_axis_x;
			break;
		}
		case CPU_INPUT.Y:
		{
			input = input_axis_y;
			break;
		}
		case CPU_INPUT.JUMP:
		{
			input = input_button.jump.check;
			break;
		}
		case CPU_INPUT.JUMP_PRESSED:
		{
			input = input_button.jump.pressed;
			break;
		}
	}
	
	array_shift(input_cpu_history[cpu_input]);
	array_push(input_cpu_history[cpu_input], input);
};

/// @method player_respawn_cpu()
/// @description Respawns the CPU to the main player's location
player_respawn_cpu = function ()
{
	var player_inst = global.players[0];

	if (instance_exists(player_inst))
	{
		if (player_inst.state != player_is_dead)
		{
			player_reset_cpu();
			invulnerability_time = invulnerability_duration;
		}
	}
}

/// @method player_reset_cpu()
/// @description Resets the CPU to match the main player
player_reset_cpu = function ()
{
	var player_inst = global.players[0];

	if (instance_exists(player_inst))
	{
		x = player_inst.x div 1;
		y = player_inst.y div 1;
		xprevious = player_inst.x div 1;
		yprevious = player_inst.y div 1;
		image_xscale = player_inst.image_xscale;
		gravity_direction = player_inst.gravity_direction;
		x_speed = player_inst.x_speed;
		y_speed = player_inst.y_speed;
		// TODO: Add Layer Collisions
		underwater = player_inst.underwater;
		player_perform(player_is_falling);
		animation_init(PLAYER_ANIMATION.ROLL);
		player_refresh_physics();
	}
}

// Animation
animation_data = new animation_core();
//animation_history = array_create(16);

// Effects
/// @function player_effect()
/// @description Creates a new player effect.
function player_effect() constructor
{
    x = 0;
    y = 0;
    sprite_index = -1;
    image_index = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
	image_alpha = 1;
    animation_data = new animation_core();
    static draw = function()
    {
        if (sprite_index != -1) draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
    };
}

spin_dash_effect = new player_effect();

// Camera
camera = noone;
camera_offset_x = 0;
camera_offset_y = 0;
camera_padding_x = 0;
camera_padding_y = 0;

// Misc.
player_index = -1;

/// @method player_perform(action, [reset])
/// @description Sets the given function as the player's current state.
/// @param {Function} action State function to set.
/// @param {Bool} [reset] Reset the current state function.
player_perform = function (action, reset = false)
{
	if (state != action or reset)
	{
		previous_state = state;
		state = action;
		state_changed = true;
		previous_state(PHASE.EXIT);
		state(PHASE.ENTER);
	}
};

/// @method player_try_jump()
/// @description Sets the player's current state to jumping, if applicable.
/// @returns {Bool}
player_try_jump = function()
{
    if (input_button.jump.pressed)
    {
        player_perform(player_is_jumping);
        animation_init(object_index == objAmy ? PLAYER_ANIMATION.SPRING : PLAYER_ANIMATION.JUMP);
        return true;
    }
    return false;
};

/// @method player_rotate_mask()
/// @description Rotates the player's virtual mask, if applicable.
player_rotate_mask = function ()
{
	static rotation_lock_time = 0;
	if (rotation_lock_time > 0) then --rotation_lock_time;
	
	var new_rotation = (round(direction / 90) mod 4) * 90;
	if (mask_direction != new_rotation and (landed or rotation_lock_time == 0))
	{
		mask_direction = new_rotation;
		rotation_lock_time = (not landed) * max(16 - abs(x_speed * 2) div 1, 0);
	}
};

/// @method player_resist_slope(force)
/// @description Applies slope friction to the player's horizontal speed, if appropriate.
/// @param {Real} force Friction value to use.
player_resist_slope = function (force)
{
	// Abort if...
	if (x_speed == 0 and control_lock_time == 0) exit; // Not moving
	if (local_direction < 22.5 or local_direction > 337.5) exit; // Moving along a shallow slope
	if (local_direction >= 135 and local_direction <= 225) exit; // Attached to a ceiling
	
	// Apply
	x_speed -= dsin(local_direction) * force;
};

/// @method player_animate()
/// @description Sets the player's current animation.
player_animate = function () {};

/// player_animate_run(ani)
/// @description Sets the given animation as the player's run animation.
/// @param {Array} ani Animations to set.
player_animate_run = function (ani)
{
    var variant = animation_data.variant;
    if (on_ground)
    {
    	var abs_speed = abs(x_speed);
        variant = 5;
    	if (abs_speed <= 1.25) variant = 0;
	    else if (abs_speed <= 2.5) variant = 1;
	    else if (abs_speed <= 4.0) variant = 2;
	    else if (abs_speed <= 9.0) variant = 3;
	    else if (abs_speed <= 10.0) variant = 4;
    }
    animation_set(ani);
    animation_data.variant = variant;
    if (on_ground) animation_data.speed = clamp((abs(x_speed) / 3) + (abs(x_speed) / 4), 0.5, 8);
};

/// @method player_set_radii(xrad, yrad)
/// @description Sets the given radii as the player's virtual mask.
/// @param {Real} xrad Horizontal radius to use.
/// @param {Real} yrad Vertical radius to use.
player_set_radii = function (xrad, yrad)
{
    // Abort if radii already match
    if (x_radius == xrad and y_radius == yrad) exit;
    
    var old_x_radius = x_radius;
    var old_y_radius = y_radius;
    var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
    x_radius = xrad;
    x_wall_radius = x_radius + 2;
    y_radius = yrad;
	player_new_position(x + (sine * (old_y_radius - y_radius)), y + (cosine * (old_y_radius - y_radius)));
};

/// @method player_draw_before()
/// @description Draws player effects behind the character sprite.
player_draw_before = function () {};

/// @method player_draw_after()
/// @description Draws player effects in front of the character sprite.
player_draw_after = function () {};

/// @method player_set_rings(amount)
/// @description Sets the player's ring count to the given amount.
/// @param {Real} amount Amount of rings to give.
player_set_rings = function (amount)
{
	global.rings = clamp(amount, 0, 999)
};

/// @method player_set_lives(amount)
/// @description Sets the player's life count to the given amount.
/// @param {Real} amount Amount of lives to give.
player_set_lives = function (amount)
{
	global.lives = clamp(amount, 0, 99);
};

/// @method player_set_score(num)
/// @description Sets the player's score count to the given amount.
/// @param {Real} amount Amount of score points to give.
player_set_score = function (amount)
{
	global.score = clamp(amount, 0, 999999);
};

/// @method player_gain_rings(num)
/// @description Increases the player's ring count by the given amount.
/// @param {Real} num Amount of rings to give.
player_gain_rings = function(num)
{
	player_set_rings(global.rings + num);
	sound_play(sfxRing);
	
	// Gain lives
	static ring_life_threshold = 99;
	if (global.rings > ring_life_threshold)
	{
		var change = global.rings div 100;
		player_gain_lives(change - ring_life_threshold div 100);
		ring_life_threshold = change * 100 + 99;
	}
};

/// @method player_gain_lives(num)
/// @description Increases the player's life count by the given amount.
/// @param {Real} num Amount of lives to give.
player_gain_lives = function(num)
{
	player_set_lives(global.lives + num);
	music_overlay(bgmLife);
};

/// @method player_gain_score(num)
/// @description Increases the player's score count by the given amount.
/// @param {Real} num Amount of score points to give.
player_gain_score = function (num)
{
	player_set_score(global.score + num);
	
	// Gain lives
	static score_life_threshold = 49999;
	if (global.score > score_life_threshold)
	{
		var change = global.score div 50000;
		player_gain_lives(change - score_life_threshold div 50000);
		score_life_threshold = change * 50000 + 9999;
	}
};

/// @method player_ring_loss()
/// @description Drop a ring of rings.
/// @returns {Id.Instance}
player_ring_loss = function ()
{
	var total = min(global.rings, 32);
	var dir = 101.25;
	var len = 4;

	while (total)
	{
		var ring_inst = instance_create_layer(x div 1, y div 1, "ZoneObjects", objRing);
	}
	
	player_set_rings(0);
}

/// @method player_damage(inst)
/// @description Sets the player state to being hurt or dying. Setting the inst to the player is instant death.
/// @param {Id.Instance} inst Instance to damage from.
player_damage = function (inst)
{
	if (state == player_is_dead 
	or ((state == player_is_hurt or invulnerability_time > 0 or invincibility_time > 0) 
	and inst != self)) 
	{
		exit;
	}
	
	var damage_inst = inst.id;
	var hurt_direction = esign(x - damage_inst.x, 1);
	
	if (damage_inst == id or (global.rings == 0 and player_index == 0))
	{
		player_perform(player_is_dead);
		if (drown == false)
		{
			y_speed = -7;
		}
		else
		{
			
		}
	}
	else
	{
		x_speed = (underwater ? 2 : 1) * hurt_direction;
		y_speed = (underwater ? -4 : -2);
		player_perform(player_is_hurt);
		
		if (player_index == 0)
		{
			player_ring_loss();
		}
	}
}