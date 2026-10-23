// 1. Capture the exact input accept key state
var key_interact = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);

// 2. Validate player existence before calculating distance coordinates
if (instance_exists(obj_kris_hollow)) {
    
    // Calculate the precise pixel distance between this object instance mask and Kris
    var distance_to_player = distance_to_object(obj_kris_hollow);
    
    // Proximity gate check: Must be right next to the item (within 12-16 pixels) and hitting Z
    if (distance_to_player <= 14 && key_interact) {
        
        // 3. Target your persistent menu object controller array tree space
        if (instance_exists(obj_pause_menu)) {
            
            var added_successfully = false;
            var menu_ref = obj_pause_menu;
            
            // Iterate down the string-array slots to search for an available empty cell row
            for (var i = 0; i < array_length(menu_ref.menu_items); i++) {
                if (menu_ref.menu_items[i] == "Empty Slot") {
                    
                    // Drop our custom instance string parameter straight into the empty slot cell!
                    menu_ref.menu_items[i] = item_to_give;
                    added_successfully = true;
					
					  
            var _textbox = instance_create_layer(0, 0, "Instances", obj_dialogue_box);
            _textbox.text_array = "* You got the " + string(item_to_give) + ".";
            _textbox.face_array = -1; 
            _textbox.dialogue_page = 0;
            _textbox.char_index = 0;
            _textbox.text_visible = "";
                    
                    // Trigger your standard UI confirmation or scrolling audio chime feedback hook
                    if (audio_exists(snd_menuselect)) {
                        audio_play_sound(snd_menuselect, 1, false);
                    }
                    
                    break; // Instant break out of the loop calculations on placement home found
                }
            }
            
            // 4. Cleanup and auto-save synchronization routine
            if (added_successfully) {
              
                
                
                // Vanish out of the active overworld map layer space permanently
                instance_destroy();
            } else {
                // Optional Fallback: Handle packed inventory block scenario
                show_debug_message("Cannot take item: Dark World item stash space is full!");
            }
        }
    }
}
