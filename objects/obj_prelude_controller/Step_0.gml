// ========================================================
// PROLOGUE CUTSCENE BYPASS CORE (X KEY SKIP UNLOCKED)
// ========================================================

// 1. Monitor if the player taps the cancel/sprint button (X or Shift)
if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
    
    // 2. THE MULTI-SLOT RE-FIX: Check if ANY save profile slot exists!
    var _has_any_saves = false;
    for (var s = 1; s <= 3; s++) {
        if (file_exists("save_collapse_slot_" + string(s) + ".ini")) {
            _has_any_saves = true;
            break;
        }
    }
    
    // 3. If save data is found anywhere, skip straight to the main title launcher room!
    if (_has_any_saves == true) {
        
        // Purge dialogue box assets if any are lingering
        if (instance_exists(obj_dialogue_box)) {
            instance_destroy(obj_dialogue_box);
        }
        
        // Wipes all intro music channels safely before transitioning
        audio_stop_all(); 
        
        // 4. SECURELY JUMP DIRECTLY INTO YOUR TITLE SCREEN LAUNCHER
        room_goto(rm_main_menu);
        
        // Destroy this intro controller object instance so it stops processing code
        instance_destroy(); 
    }
}

// ========================================================
// 1. TYPEWRITER PROCESSING ENGINE
// ========================================================
var _current_target = prelude_text[prelude_page];

if (char_index < string_length(_current_target)) {
    var _old_index = floor(char_index);
    char_index += type_speed;
    text_visible = string_copy(_current_target, 1, floor(char_index));
    
    // Play your text sound bleep every time a new letter pops up
    if (floor(char_index) > _old_index) {
        audio_play_sound(snd_text_bleep, 1, false); 
    }
}

// ========================================================
// 2. INPUT SKIP & PROGRESSION (Press Z or Spacebar)
// ========================================================
if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
    // If the line is still typing, instantly finish revealing it
    if (char_index < string_length(_current_target)) {
        char_index = string_length(_current_target);
        text_visible = _current_target;
    } 
    // If the line was already finished, move to the next page!
    else {
        if (prelude_page < array_length(prelude_text) - 1) {
            prelude_page += 1;
            char_index = 0;
            text_visible = "";
        } 
        // THE FIX: The final page has finished and the player clicked Z again!
        else {
            io_clear(); // Flush key trackers so it doesn't auto-click "New Game"
            
            // Kill any looping intro ambiance sounds smoothly
            audio_stop_all(); 
            
            // Warp the player safely straight to your newly upgraded multi-slot main menu!
            room_goto(rm_main_menu); 
            
            // Destroy this intro object cleanly so it frees up engine memory
            instance_destroy();
        }
    }
}

