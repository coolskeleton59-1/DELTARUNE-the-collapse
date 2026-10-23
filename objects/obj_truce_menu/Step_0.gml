if (menu_active) {
    // 1. Navigate left and right with Arrow Keys
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) {
        // Toggle between 0 and 1
        menu_select = (menu_select == 0) ? 1 : 0; 
        audio_play_sound(snd_text_bleep, 1, false); // Play menu tick sound
    }
    
    // 2. Confirm selection with Space or Z key
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"))) {
        
        // IF PLAYER CHOOSES YES: Seal the link and unlock control!
        if (menu_select == 0) {
            menu_active = false;
            global.truce_phase = 2; // Advance to Phase 2: FULL PLAYER CONTROL!
            
            // Play a loud confirmation or healing chime sound here if you have one!
            audio_play_sound(snd_text_bleep, 1, false); 
            
            // Delete the prisoner soul heart object completely since the link is sealed!
            if (instance_exists(obj_soul_prisoner)) {
                instance_destroy(obj_soul_prisoner);
            }
            
            instance_destroy(); // Close the menu choice window
        } 
        // IF PLAYER CHOOSES NO: Play a generic rejection bleep and do nothing
        else {
            audio_play_sound(snd_text_bleep, 1, false); // Rejection buzz
        }
    }
}
