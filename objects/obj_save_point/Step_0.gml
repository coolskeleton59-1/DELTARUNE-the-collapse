// ========================================================
// RE-CALIBRATED STANDALONE SAVE STAR (STEP EVENT)
// ========================================================

// STATE A: THE INITIAL OVERWORLD INTERACTION DETECTOR
if (!is_selecting_slot) {
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
        if (instance_exists(obj_kris_hollow)) {
            if (distance_to_object(obj_kris_hollow) < 24) {
                if (!instance_exists(obj_dialogue_box)) {
                    // Turn on the local slot selection menu state!
                    is_selecting_slot = true;
                    local_slot_index = 0; // Reset your cursor arrow to Slot 1
                    io_clear(); // Flush key trackers to prevent double-clicks
                }
            }
        }
    }
}
// STATE B: THE SAVE FILE SLOT SELECTION OVERLAY IS OPEN
else {
    // 1. Move up and down through Slot 1, Slot 2, Slot 3, and the Cancel row
    if (keyboard_check_pressed(vk_down)) {
        local_slot_index = (local_slot_index + 1) % 4;
        audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    }
    if (keyboard_check_pressed(vk_up)) {
        local_slot_index = (local_slot_index - 1 + 4) % 4;
        audio_play_sound(snd_menuselect, 5, false, global.sound_volume / 100);
    }
    
    // 2. Press X or Shift to back out safely without saving any files
    if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
        is_selecting_slot = false;
        io_clear();
    }
    
    // 3. Freeze Kris's animations completely while browsing the local file index boxes
    if (instance_exists(obj_kris_hollow)) {
        obj_kris_hollow.image_speed = 0;
    }
    
    // 4. Press Z or Enter to confirm your target slot
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        if (local_slot_index == 3) { // User clicked [ CANCEL ]
            is_selecting_slot = false;
            io_clear();
        } else {
            // THE CRUCIAL FIX: Lock in your active slot choice globally!
            global.active_save_slot = local_slot_index + 1; // Converts index 0,1,2 to Slot 1,2,3
            
            // Execute your multi-slot save function natively!
            save_game_data();
            
            // Turn off the local selection menu state
            is_selecting_slot = false;
            
            // Spawn your original save text box using your exact text_array requirements!
            var _textbox = instance_create_layer(0, 0, "Instances", obj_dialogue_box);
            _textbox.text_array = "* (The light of the timeline shines through the darkness.)\n* (File saved to Slot " + string(global.active_save_slot) + ".)";
            _textbox.face_array = -1; 
            _textbox.dialogue_page = 0;
            _textbox.char_index = 0;
            _textbox.text_visible = "";
            
            io_clear();
        }
    }
}



