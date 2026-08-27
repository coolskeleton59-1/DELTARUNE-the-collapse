
// Loops through all 20 of your initialized background star particles every frame!
for (var i = 0; i < 20; i++) {
    // Gently scroll the particles horizontally across the native 640p screen canvas
    star_x[i] -= 0.5; // Change this number to adjust your preferred scroll velocity!
    
    // LOOP RECYCLING: If a star drifts completely off the left edge of the screen frame...
    if (star_x[i] < -5) {
        star_x[i] = 645; // Wrap it seamlessly right back to the far right edge!
        star_y[i] = irandom_range(0, 480); // Assign a fresh random vertical height row
    }
}



switch (current_state) {
    
    // MODE 0: THE ROOT MAIN SELECTION MATRIX
    case menu_states.main_options:
        if (keyboard_check_pressed(vk_down)) {
            menu_index = (menu_index + 1) % 4;
            // AUDIO INJECT: Play a crisp selection sound scaled to your sound volume variable
            audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
        }
        if (keyboard_check_pressed(vk_up)) {
            menu_index = (menu_index - 1 + 4) % 4;
            // AUDIO INJECT: Play a crisp selection sound scaled to your sound volume variable
            audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
        }
        
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            switch (menu_index) {
                case 0: // NEW GAME selected
    slot_menu_mode = "new_game"; // Track if clicking a slot starts a new journey
    current_state = menu_states.save_slots;
    menu_index = 0; // Reset arrow cursor to Slot 1
    audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    break;
                    
          case 1: // CONTINUE selected
    if (can_continue) { // Only open if at least one slot .ini exists
        slot_menu_mode = "continue"; // Track if clicking a slot loads an old save
        current_state = menu_states.save_slots;
        menu_index = 0;
        audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    }
    break;

                case 2: // CONFIG PANEL
                    current_state = menu_states.config_panel;
                    menu_index = 0; // Moves cursor to your Music volume row
                    break;
                    
                case 3: // CONTROLS VIEW
                    current_state = menu_states.controls_view;
                    break;
            }
        }
        break;
        
      // MODE 1: CONFIGURATION AUDIO & GRAPHICS PANEL
    case menu_states.config_panel:
        if (keyboard_check_pressed(vk_down)) {
            menu_index = (menu_index + 1) % 4;
            audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
        }
        if (keyboard_check_pressed(vk_up)) {
            menu_index = (menu_index - 1 + 4) % 4;
            audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
        }
        
        // Track whether any setting actually changed this frame
        var _setting_changed = false;
        
        // Handle Item 0: Music Slider
        if (menu_index == 0) {
            if (keyboard_check(vk_left))  { global.music_volume = max(0, global.music_volume - 1); _setting_changed = true; }
            if (keyboard_check(vk_right)) { global.music_volume = min(100, global.music_volume + 1); _setting_changed = true; }
            if (audio_is_playing(snd_menu_theme)) audio_sound_gain(snd_menu_theme, global.music_volume / 100, 0);
			if (audio_is_playing(snd_hometown_theme)) audio_sound_gain(snd_hometown_theme, global.music_volume / 100, 0);
        }
        
        // Handle Item 1: SFX Slider
        if (menu_index == 1) {
            if (keyboard_check(vk_left))  { global.sound_volume = max(0, global.sound_volume - 1); _setting_changed = true; }
            if (keyboard_check(vk_right)) { global.sound_volume = min(100, global.sound_volume + 1); _setting_changed = true; }
        }
        
        // Handle Item 2: Fullscreen Switcher Trigger
        if (menu_index == 2) {
            if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_left)) {
                var _is_full = window_get_fullscreen();
                window_set_fullscreen(!_is_full);
                _setting_changed = true;
            }
        }
        
        // INSTANT HARD DRIVE WRITE: Saves data immediately if a player altered a slider or screen frame!
        if (_setting_changed) {
            ini_open("config_collapse.ini");
            ini_write_real("Settings", "music", global.music_volume);
            ini_write_real("Settings", "sound", global.sound_volume);
            ini_write_real("Settings", "fullscreen", window_get_fullscreen() ? 1 : 0);
            ini_close();
        }
        
        // Break out back to main list
        if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift) || (menu_index == 3 && keyboard_check_pressed(ord("Z")))) {
            current_state = menu_states.main_options;
            menu_index = 2; 
        }
        break;

        
        
    // MODE 2: KEYMAP CARD VIEW
    case menu_states.controls_view:
        if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
            current_state = menu_states.main_options;
            menu_index = 3; // Returns cursor onto the main CONTROLS button line
        }
        break;



case menu_states.save_slots:
    // Move up and down through Slot 1, 2, 3, and a Back button
    if (keyboard_check_pressed(vk_down)) {
        menu_index = (menu_index + 1) % 4; // 0=Slot1, 1=Slot2, 2=Slot3, 3=Back
        audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    }
    if (keyboard_check_pressed(vk_up)) {
        menu_index = (menu_index - 1 + 4) % 4;
        audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    }
    
    // Press X or Shift to head back to the root launcher choices
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        current_state = menu_states.main_options;
        menu_index = (slot_menu_mode == "new_game") ? 0 : 1; // Return cursor safely
        audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    }
    
    // Press Z or Enter to execute your save/load logic
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
		audio_stop_all()
        if (menu_index == 3) { // User clicked the [ BACK ] row
            current_state = menu_states.main_options;
            menu_index = (slot_menu_mode == "new_game") ? 0 : 1;
            audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
        } else {
            // LOCK IN THE SELECTION: Set your global active slot dynamically!
            global.active_save_slot = menu_index + 1; // Converts index 0,1,2 to Slot 1,2,3
            
            if (slot_menu_mode == "new_game") {
                // Wipe any old file on this slot to start completely fresh
                var _old_file = "save_collapse_slot_" + string(global.active_save_slot) + ".ini";
                if (file_exists(_old_file)) file_delete(_old_file);
                
                audio_stop_all();
                global.truce_phase = 0;
                global.money = 0;
                room_goto(Room1); // Launch new adventure
            } else {
                // Run your newly updated load logic from your exact slot file choice!
                load_game_data(); 
            }
        }
    }
    break;
}
// ========================================================
// RE-CALIBRATED SMOOTH DUAL-AXIS CURSOR ENGINE
// ========================================================

// 1. Establish your baseline default targets (Root Option parameters)
var _target_soul_x = 210;
var _target_soul_y = 284 + (menu_index * 40);

// 2. Adjust target destinations based on active screen alignment
if (current_state == menu_states.save_slots) {
    // Dynamic X/Y coordinate targets for save slots
    _target_soul_x = (menu_index == 3) ? 180 : 70;
    _target_soul_y = (menu_index == 3) ? 404 : 190 + (menu_index * 75);
}
else if (current_state == menu_states.config_panel) {
    // Dynamic X/Y coordinate targets for config rows
    _target_soul_x = (menu_index == 3) ? 170 : 70;
    _target_soul_y = (menu_index == 3) ? 364 : 194 + (menu_index * 50);
}

// 3. THE KINETIC SMOOTHING FIX: Smoothly slide BOTH axes at the exact same rate!
soul_x = lerp(soul_x, _target_soul_x, 0.25);
soul_y = lerp(soul_y, _target_soul_y, 0.25);

// ========================================================
// RE-CALIBRATED UN-SCUFFED STATE FADE ENGINE
// ========================================================

// 1. If our current menu state doesn't match the last frame, a screen swap just happened!
if (current_state != last_menu_state) {
    menu_fade_alpha = 0.0; // Drop the screen visibility to zero so it can fade in cleanly
    last_menu_state = current_state; // Update the tracker to lock onto the new state
}

// 2. Every single frame, smoothly glide the transparency right back up to 100% full visibility
menu_fade_alpha = lerp(menu_fade_alpha, 1.0, 0.12);

