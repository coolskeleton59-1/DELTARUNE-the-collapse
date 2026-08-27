
	
if (global.game_frozen) 
{
    // Stop all moving velocities so the player doesn't slide into walls during the fade
    hspeed = 0; 
    vspeed = 0;
image_index = 0;
image_speed = 0;
   
    
    exit; // Stops the rest of the movement/input code from running this frame
}

if (room == Room1 && y > room_height + 40 && kris_state == 1) {
    kris_state = 2;
    vspeed = 0; // Stop moving
    // Check if the fade controller doesn't exist yet, then create it
    if (!instance_exists(obj_fade_controller)) {
        instance_create_layer(0, 0, "Instances", obj_fade_controller);
    }
}

// Simple Street Warp: If Kris walks off the bottom of the yard, load the streets!
if (room == rm_kris_driveway && y > room_height) {
    room_goto(rm_hometown_streets);
}

if (room == rm_street_north) {
    // Check if Kris has reached the absolute 100% end of their walk path
    if (path_position == 1) {
        // Spawn the dialogue typewriter block if it doesn't exist yet!
        if (!instance_exists(obj_dialogue_box)) {
            var _textbox = instance_create_layer(0, 0, "Instances", obj_dialogue_box);
            // Inject Susie's text straight into the dialogue engine
            _textbox.dialogue_text = "* ... Huh?\n* Kris? What the hell are you staring at?";
        }
    }
}

// ========================================================
// PHASE 2: MANUAL OVERWORLD PLAYER CONTROL
// ========================================================
if (global.truce_phase >1) {
	

	if (!audio_is_playing(snd_hometown_theme)) {
    // Arguments: (index, priority, loop, gain)
    // Automatically references your saved config volume slider percentages!
   if room == Room1 || rm_prelude || rm_main_menu{audio_stop_sound(snd_hometown_theme);}
   else {audio_play_sound(snd_hometown_theme, 10, true, global.music_volume / 100);}
   if room == rm_kris_hallway {audio_play_sound(snd_hometown_theme, 10, true, global.music_volume / 100);}
}

    
// ========================================================
// 1. CALCULATE INPUTS FIRST (FIXES LINE 49 CRASH!)
// ========================================================
// Grabs your standard directional button signals cleanly
var _input_x = keyboard_check(vk_right) - keyboard_check(vk_left);
var _input_y = keyboard_check(vk_down) - keyboard_check(vk_up);

// ========================================================
// 2. RE-BALANCED RUN MODIFIER (COLLISION SAFE)
// ========================================================
var _walk_speed = 2; // Your standard, working walking pace

// Hold X or Shift to instantly alter the active speed step multiplier
if (keyboard_check(ord("X")) || keyboard_check(vk_shift)) {
    _walk_speed = 4;   // Boosts your speed variable smoothly for sprinting
    image_speed = 0.45; // Accelerate feet animation cycles smoothly
} else {
    _walk_speed = 2;   // Restore normal walking pace bounds
    image_speed = 0.25; // Restore smooth, casual animation frame rates
}
	if (global.game_frozen) 
{
    // Stop all moving velocities so the player doesn't slide into walls during the fade
    hspeed = 0; 
    vspeed = 0;
_walk_speed = 0
}

// ========================================================
// 3. EXECUTE MOVEMENT USING CALIBRATED VALUE VARIABLES
// ========================================================
var _move_x = _input_x * _walk_speed;
var _move_y = _input_y * _walk_speed;

    
    // 2. DIRECTION SNAPPING
    if (_input_x != 0) {
        face_direction = (_input_x > 0) ? 0 : 2; // 0 = Right, 2 = Left
    }
    if (_input_y != 0) {
        face_direction = (_input_y > 0) ? 3 : 1; // 3 = Down, 1 = Up
    }
	
	    
    // 4. VERSATILE INTERACTION SCANNER
    // ========================================================
    if (!instance_exists(obj_dialogue_box)) {
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
            
            var _check_x = 0;
            var _check_y = 0;
            var _dist = 12; 
            
            if (face_direction == 0) _check_x = _dist;  
            if (face_direction == 2) _check_x = -_dist; 
            if (face_direction == 1) _check_y = -_dist; 
            if (face_direction == 3) _check_y = _dist;  
            

var _interact_target = instance_position(x + _check_x, y + _check_y, obj_readable);

            
            if (_interact_target == noone) {
                _interact_target = instance_position(x + _check_x, y + _check_y, obj_save_point);
            }
            
            if (_interact_target != noone) {
           
                
               // ========================================================
// RE-CALIBRATED INTERACTION SYSTEM (ARRAY-SAFE HANDSHAKE)
// ========================================================
var _textbox = instance_create_depth(0, 0, 0, obj_dialogue_box);
_textbox.face_array = _interact_target.face_array;

// THE FIX: Check if the readable object is carrying a multi-page array list first!
if (variable_instance_exists(_interact_target, "my_text_array")) {
    _textbox.text_array = _interact_target.my_text_array; // Passes your 10-page array natively!
} else {
    _textbox.text_array = _interact_target.my_text; // Fallback for your original single-line signposts
}

                _textbox.face_array = _interact_target.face_array; 
                
                if (variable_instance_exists(_interact_target, "is_susie_bedroom_chat")) {
                    _textbox.is_susie_bedroom_chat = _interact_target.is_susie_bedroom_chat;
                } else {
                    _textbox.is_susie_bedroom_chat = false;
                }
                
                _textbox.dialogue_page = 0;
                _textbox.char_index = 0;
                _textbox.text_visible = "";
            } // Closes: if (_interact_target != noone)
        } // Closes: if (keyboard_check_pressed)
    } // Closes: if (!instance_exists)



    // 3. COLLISION SYSTEM (Checking against obj_wall)
    // Horizontal Collision Check
    if (_move_x != 0) { // Safety fix so sign(_move_x) never equals zero!
        if (place_meeting(x + _move_x, y, obj_wall)) {
            while (!place_meeting(x + sign(_move_x), y, obj_wall)) {
                x += sign(_move_x);
            }
            _move_x = 0; 
        }
    }
    x += _move_x; 

    // Vertical Collision Check
    if (_move_y != 0) { // Safety fix so sign(_move_y) never equals zero!
        if (place_meeting(x, y + _move_y, obj_wall)) {
            while (!place_meeting(x, y + sign(_move_y), obj_wall)) {
                y += sign(_move_y);
            }
            _move_y = 0; 
        }
    }
    y += _move_y; 

    // 4. ANIMATION CONTROLLER (Tied to actual movement)
    if (_move_x != 0 || _move_y != 0) {
        sprite_index = sprite_walk[face_direction];
        image_speed = 0.25; 
    } 
    else {
        image_speed = 0; 
		image_index = 0
    }
    
    // Force GameMaker's built-in speeds to 0 so they don't override our collision system
    hspeed = 0;
    vspeed = 0;
}
// MASTER DEPTH SORTING: Higher Y coordinate = drawn closer to the screen!
depth = -y;

// ========================================================
// SYSTEM KEY CHECK: LOAD GAME FILE DATA
// ========================================================
// Change "vk_f9" to ord("L") if you prefer the L key for testing!
if (keyboard_check_pressed(vk_f9)) {
    
    // Check if a real save file exists on the computer hard drive
    if (file_exists("save_collapse.ini")) {
        
        // 1. Destroy any stray dialogue boxes so Kris isn't permanently frozen
        if (instance_exists(obj_dialogue_box)) {
            with (obj_dialogue_box) { instance_destroy(); }
        }
        
        // 2. Clear out keyboard buffer memory to prevent action button repetition echo loops [Context]
        io_clear(); 
        
        // 3. Execute your universal file reader function from scr_save_system! [Context]
        load_game_data();
    }
}


// 5. UPDATE TRAIL HISTORY FOR SUSIE
// Only record if he actually changed positions this frame!
if (x != xprevious || y != yprevious) {
    ds_list_insert(kris_history_x, 0, x);
    ds_list_insert(kris_history_y, 0, y);
}

// Caps the list size at 100 entries so your game never slows down
if (ds_list_size(kris_history_x) > 100) {
    ds_list_delete(kris_history_x, 100);
    ds_list_delete(kris_history_y, 100);
}

